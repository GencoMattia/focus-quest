import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _estimatedDuration = 15;
  String _urgency = 'medium';
  DateTime? _deadline;
  String? _historyFeedback;
  int? _suggestedDuration;

  Future<void> _checkHistoryStats(String title) async {
    final stats = await ref.read(taskRepositoryProvider).getTaskCompletionStats(title);
    
    if (stats != null) {
      final avgEst = stats['avgEstimated']!.round();
      final avgAct = stats['avgActual']!.round();
      final diff = avgAct - avgEst;

      String msg;
      if (diff > 5) {
        msg = "Di solito preventivi $avgEst min, ma ci metti $avgAct min.\nTi consiglio di impostare $avgAct min per stare serenə! 🧘";
      } else if (diff < -5) {
        msg = "Sei violentissimə! 💪 Preventivi $avgEst min ma finisci in $avgAct.\nHai risparmiato ${diff.abs()} min!";
      } else {
        msg = "Ottimo! Le tue stime ($avgEst min) sono molto precise. Continua così! 🎯";
      }

      setState(() {
        _suggestedDuration = avgAct; // Suggest the ACTUAL time
        _historyFeedback = msg;
      });
    } else {
      setState(() {
        _historyFeedback = null;
        _suggestedDuration = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova Attività'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      // Fetch distinct titles from repo using Riverpod
                      final allTitles = await ref.read(taskRepositoryProvider).getDistinctTaskTitles();
                      return allTitles.where((String option) {
                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _titleController.text = selection;
                      _checkHistoryStats(selection);
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      // Sync local controller with Autocomplete's controller
                      if (_titleController.text != controller.text) {
                        controller.text = _titleController.text;
                      }
                      return TextFormField(
                        controller: controller, // Use the Autocomplete controller
                        focusNode: focusNode,
                        onChanged: (val) {
                          _titleController.text = val; // Keep master controller synced
                        },
                        decoration: const InputDecoration(
                          labelText: 'Titolo',
                          hintText: 'Cosa devi fare?',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.edit_outlined),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Inserisci un titolo' : null,
                      );
                    },
                  );
                }
              ),
              // Feedback Widget
              if (_historyFeedback != null && _suggestedDuration != null) ...[
                const SizedBox(height: 12),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _estimatedDuration = _suggestedDuration!;
                        _historyFeedback = "Tempo aggiornato a $_estimatedDuration min! 🚀";
                        _suggestedDuration = null; // Disable further clicks for this suggestion
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.calmBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.calmBlue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, color: AppColors.calmBlue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _historyFeedback!,
                              style: const TextStyle(color: AppColors.textDark, fontSize: 13),
                            ),
                          ),
                          const Icon(Icons.touch_app, size: 16, color: AppColors.textLight),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione (opzionale)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Text('Tempo stimato', style: Theme.of(context).textTheme.bodyLarge),
              Slider(
                value: _estimatedDuration.toDouble(),
                min: 5,
                max: 120,
                divisions: 23,
                label: '$_estimatedDuration min',
                activeColor: AppColors.calmBlue,
                onChanged: (val) {
                  setState(() => _estimatedDuration = val.round());
                },
              ),
              Text('$_estimatedDuration minuti', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _urgency,
                decoration: const InputDecoration(
                  labelText: 'Urgenza',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'low', child: Text('Bassa - Nessuna fretta')),
                  DropdownMenuItem(value: 'medium', child: Text('Media - Importante')),
                  DropdownMenuItem(value: 'high', child: Text('Alta - Da fare subito')),
                ],
                onChanged: (val) => setState(() => _urgency = val!),
              ),
              const SizedBox(height: 24),
              ListTile(
                title: Text(_deadline == null
                    ? 'Nessuna scadenza'
                    : 'Scadenza: ${_deadline!.day}/${_deadline!.month}/${_deadline!.year}'),
                trailing: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey)),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() => _deadline = date);
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Salva Attività'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = TasksCompanion(
        id: drift.Value(const Uuid().v4()),
        userId: const drift.Value('current_user_id'), // Mock User ID
        title: drift.Value(_titleController.text),
        description: drift.Value(_descController.text),
        estimatedDuration: drift.Value(_estimatedDuration),
        urgency: drift.Value(_urgency),
        deadline: drift.Value(_deadline),
        createdAt: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      );

      ref.read(taskRepositoryProvider).createTask(task);
      context.pop();
    }
  }
}
