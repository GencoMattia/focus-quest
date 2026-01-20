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

class _TaskExecutionScreenState extends ConsumerState<TaskExecutionScreen> with SingleTickerProviderStateMixin {
  Task? _task;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isPaused = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
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
           _isPaused = true;
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
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: AppColors.textOnColor),
                SizedBox(width: AppTheme.spaceSm),
                Text('Foto aggiunta! 📸'),
              ],
            ),
          ),
        );
      }
    }
  }

  Color _getIntensityColor(int intensity) {
    if (intensity <= 2) return AppColors.error;
    if (intensity == 3) return AppColors.warning;
    return AppColors.success;
  }

  Future<void> _showEmotionalCheckin({required String contextLabel}) async {
    int? selectedIntensity;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceXs),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, color: AppColors.primary),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                const Expanded(child: Text('Come ti senti?')),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Il tuo stato d\'animo è importante per noi',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppTheme.spaceLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    final intensity = index + 1;
                    final isSelected = selectedIntensity == intensity;
                    final color = _getIntensityColor(intensity);
                    
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setDialogState(() => selectedIntensity = intensity);
                            },
                            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? color
                                    : color.withOpacity(0.2),
                                border: Border.all(
                                  color: color,
                                  width: isSelected ? 3 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$intensity',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? AppColors.textOnColor
                                        : color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXs),
                        Text(
                          _getEmotionLabel(intensity),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: AppTheme.spaceSm),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Salta'),
              ),
              FilledButton(
                onPressed: selectedIntensity == null ? null : () {
                  final log = EmotionalLogsCompanion(
                    id: drift.Value(const Uuid().v4()),
                    taskId: drift.Value(_task!.id),
                    userId: const drift.Value('current_user'),
                    intensity: drift.Value(selectedIntensity),
                    context: drift.Value(contextLabel),
                    createdAt: drift.Value(DateTime.now()),
                  );
                  ref.read(taskRepositoryProvider).addEmotionalLog(log);
                  Navigator.pop(context);
                },
                child: const Text('Salva'),
              ),
            ],
          );
        }
      ),
    );
  }

  String _getEmotionLabel(int intensity) {
    switch (intensity) {
      case 1: return 'Pessimo';
      case 2: return 'Male';
      case 3: return 'Ok';
      case 4: return 'Bene';
      case 5: return 'Ottimo';
      default: return '';
    }
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
        startTime: drift.Value(DateTime.now().subtract(Duration(seconds: _elapsedSeconds))),
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
        // Show success dialog
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceLg),
                  decoration: BoxDecoration(
                    color: AppColors.successLight.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 64,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceLg),
                Text(
                  'Complimenti!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Text(
                  'Hai completato l\'attività',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spaceLg),
                FilledButton(
                  onPressed: () {
                    context.pop(); // Close dialog
                    context.pop(); // Return to dashboard
                  },
                  child: const Text('Continua'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final estimatedMinutes = _task!.estimatedDuration;
    final estimatedSeconds = estimatedMinutes * 60;
    final progress = estimatedSeconds > 0 
        ? (_elapsedSeconds / estimatedSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Focus Mode'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Vuoi uscire?'),
                content: const Text('Il timer verrà fermato ma i progressi saranno salvati.'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Rimani'),
                  ),
                  FilledButton(
                    onPressed: () {
                      context.pop(); // Close dialog
                      context.pop(); // Return to previous screen
                    },
                    child: const Text('Esci'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: _attachImage,
            tooltip: 'Aggiungi foto',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            children: [
              // Task info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Task title
                    Text(
                      _task!.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_task!.description != null) ...[
                      const SizedBox(height: AppTheme.spaceSm),
                      Text(
                        _task!.description!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    const SizedBox(height: AppTheme.space2xl),
                    
                    // Animated timer circle
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = _isPaused ? 1.0 : 1.0 + (_pulseController.value * 0.02);
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 240,
                            height: 240,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 12,
                              backgroundColor: AppColors.divider,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress >= 1.0 ? AppColors.success : AppColors.primary,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surface,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _formatDuration(_elapsedSeconds),
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _isPaused ? AppColors.textSecondary : AppColors.primary,
                                    fontFeatures: [const FontFeature.tabularFigures()],
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spaceXs),
                                Text(
                                  _isPaused ? 'In pausa' : 'In corso',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppTheme.space2xl),
                    
                    // Progress info
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spaceMd),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppTheme.spaceXs),
                          Text(
                            'Stimato: $estimatedMinutes min',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Pause/Resume button
                  _ActionButton(
                    icon: _isPaused ? Icons.play_arrow : Icons.pause,
                    label: _isPaused ? 'Riprendi' : 'Pausa',
                    color: _isPaused ? AppColors.secondary : AppColors.warning,
                    onPressed: _isPaused ? _resumeTask : _pauseTask,
                  ),
                  
                  // Complete button
                  _ActionButton(
                    icon: Icons.check,
                    label: 'Completa',
                    color: AppColors.success,
                    onPressed: _completeTask,
                    isLarge: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final s = totalSeconds % 60;
    
    if (h > 0) {
      return '${h.toString()}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final bool isLarge;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 80.0 : 64.0;
    final iconSize = isLarge ? 36.0 : 28.0;
    
    return Column(
      children: [
        Material(
          color: color,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          elevation: 4,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: iconSize,
                color: AppColors.textOnColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
