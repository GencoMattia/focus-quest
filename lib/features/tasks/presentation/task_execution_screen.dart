import 'dart:async';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/providers.dart';

class TaskExecutionScreen extends ConsumerStatefulWidget {
  final String taskId;
  const TaskExecutionScreen({super.key, required this.taskId});

  @override
  ConsumerState<TaskExecutionScreen> createState() => _TaskExecutionScreenState();
}

class _TaskExecutionScreenState extends ConsumerState<TaskExecutionScreen> {
  Task? _task;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    var task = await ref.read(taskRepositoryProvider).getTaskById(widget.taskId);
    
    if (task != null && (task.status == 'pending' || task.status == 'todo')) {
      // Auto-start task if it's pending or todo
      task = task.copyWith(
        status: 'in_progress',
        isDirty: true,
        updatedAt: DateTime.now(),
      );
      await ref.read(taskRepositoryProvider).updateTask(task);
    }

    if (mounted) {
      setState(() {
        _task = task;
        if (task != null && task.status == 'in_progress') {
           _startTimer();
           _isPaused = false;
        } else if (task != null && task.status == 'completed') {
           _isPaused = true; // Don't run timer for completed tasks
        }
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  Future<void> _attachImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null && _task != null) {
      final image = TaskImagesCompanion(
        id: drift.Value(const Uuid().v4()),
        taskId: drift.Value(_task!.id),
        localPath: drift.Value(pickedFile.path),
        createdAt: drift.Value(DateTime.now()),
      );
      
      await ref.read(taskRepositoryProvider).attachTaskImage(image);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto aggiunta! 📸')),
        );
      }
    }
  }

  Color _getIntensityColor(int intensity) {
    if (intensity <= 2) return AppColors.textLight;
    if (intensity == 3) return AppColors.calmBlue;
    return AppColors.sageGreen;
  }

  Future<void> _showEmotionalCheckin({required String contextLabel}) async {
    int? selectedIntensity;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Come ti senti? 💙'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Il tuo stato d\'animo è importante.'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    final intensity = index + 1;
                    final isSelected = selectedIntensity == intensity;
                    return IconButton(
                      icon: Icon(
                        isSelected ? Icons.circle : Icons.circle_outlined,
                        color: _getIntensityColor(intensity),
                        size: 32,
                      ),
                      onPressed: () {
                        setDialogState(() => selectedIntensity = intensity);
                      },
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Basso'), Text('Alto')],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Salta'),
              ),
              ElevatedButton(
                onPressed: selectedIntensity == null ? null : () {
                  final log = EmotionalLogsCompanion(
                    id: drift.Value(const Uuid().v4()),
                    taskId: drift.Value(_task!.id),
                    userId: drift.Value('current_user'), // Mock
                    intensity: drift.Value(selectedIntensity),
                    context: drift.Value(contextLabel),
                    createdAt: drift.Value(DateTime.now()),
                  );
                  ref.read(taskRepositoryProvider).addEmotionalLog(log);
                  Navigator.pop(context);
                },
                child: const Text('Salva'),
              )
            ],
          );
        }
      ),
    );
  }

  Future<void> _pauseTask() async {
    _timer?.cancel();
    setState(() => _isPaused = true);
    await _showEmotionalCheckin(contextLabel: 'pause');
  }

  void _resumeTask() {
    _startTimer();
    setState(() => _isPaused = false);
  }

  Future<void> _completeTask() async {
    _timer?.cancel();
    
    if (_task != null) {
      final session = TaskSessionsCompanion(
        id: drift.Value(const Uuid().v4()),
        taskId: drift.Value(widget.taskId),
        startTime: drift.Value(DateTime.now().subtract(Duration(seconds: _elapsedSeconds))), // approx
        endTime: drift.Value(DateTime.now()),
        durationSeconds: drift.Value(_elapsedSeconds),
      );

      final updated = _task!.copyWith(
        status: 'completed',
        isDirty: true,
        updatedAt: DateTime.now(),
      );
      await ref.read(taskRepositoryProvider).updateTask(updated);
      await ref.read(databaseProvider).into(ref.read(databaseProvider).taskSessions).insert(session);
      
      if (mounted) {
        await _showEmotionalCheckin(contextLabel: 'complete');
      }

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ottimo lavoro! Task completata 🎉')),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppColors.warmGrey,
      appBar: AppBar(
        title: const Text('Focus Mode 🧘'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () => _attachImage(),
            tooltip: 'Aggiungi foto',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _task!.title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_task!.description != null)
              Text(
                _task!.description!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
            
            const SizedBox(height: 64),
            
            // Timer Visualization
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.calmBlue, width: 8),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  _formatDuration(_elapsedSeconds),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.calmBlue,
                    fontFeatures: [const FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 64),
            
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isPaused)
                  FloatingActionButton.large(
                    heroTag: 'pause_task',
                    backgroundColor: AppColors.lilac,
                    onPressed: _pauseTask,
                    child: const Icon(Icons.pause, color: AppColors.textDark),
                  )
                else
                  FloatingActionButton.large(
                    heroTag: 'resume_task',
                    backgroundColor: AppColors.sageGreen,
                    onPressed: _resumeTask,
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                const SizedBox(width: 32),
                FloatingActionButton.large(
                  heroTag: 'complete_task',
                  backgroundColor: AppColors.calmBlue,
                  onPressed: _completeTask,
                  child: const Icon(Icons.check, size: 48, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.pop(), 
              child: const Text('Torna alla Dashboard')
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
