import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
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
  
  // Task properties with sensible defaults
  int _estimatedDuration = 30;
  String _urgency = 'medium';
  DateTime? _deadline;
  
  // AI-powered suggestion feedback
  String? _historyFeedback;
  int? _suggestedDuration;
  bool _showSuggestions = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _checkHistoryStats(String title) async {
    if (title.length < 3) return; // Don't check for very short titles
    
    final stats = await ref.read(taskRepositoryProvider).getTaskCompletionStats(title);
    
    if (stats != null) {
      final avgEst = stats['avgEstimated']!.round();
      final avgAct = stats['avgActual']!.round();
      final diff = avgAct - avgEst;

      String msg;
      if (diff > 5) {
        msg = "💡 Di solito preventivi $avgEst min, ma ci metti $avgAct min. Ti consiglio $avgAct min.";
      } else if (diff < -5) {
        msg = "💪 Sei velocissimo! Preventivi $avgEst min ma finisci in $avgAct.";
      } else {
        msg = "🎯 Ottimo! Le tue stime ($avgEst min) sono precise!";
      }

      if (mounted) {
        setState(() {
          _suggestedDuration = avgAct;
          _historyFeedback = msg;
          _showSuggestions = true;
        });
      }
    } else {
      setState(() {
        _historyFeedback = null;
        _suggestedDuration = null;
        _showSuggestions = false;
      });
    }
  }

  void _applySuggestion() {
    if (_suggestedDuration != null) {
      setState(() {
        _estimatedDuration = _suggestedDuration!;
        _showSuggestions = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Tempo aggiornato con il suggerimento'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Nuova Attività'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title section with autocomplete
                    _buildTitleSection(),
                    
                    // AI-powered suggestion banner
                    if (_showSuggestions && _historyFeedback != null)
                      _buildSuggestionBanner(),
                    
                    const SizedBox(height: AppTheme.spaceLg),
                    
                    // Description
                    _buildDescriptionSection(),
                    
                    const SizedBox(height: AppTheme.spaceLg),
                    
                    // Duration slider
                    _buildDurationSection(),
                    
                    const SizedBox(height: AppTheme.spaceLg),
                    
                    // Urgency selector
                    _buildUrgencySection(),
                    
                    const SizedBox(height: AppTheme.spaceLg),
                    
                    // Deadline picker
                    _buildDeadlineSection(),
                    
                    const SizedBox(height: AppTheme.spaceXl),
                  ],
                ),
              ),
            ),
            
            // Bottom action bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cosa devi fare?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.length < 2) {
              return const Iterable<String>.empty();
            }
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
            if (_titleController.text != controller.text) {
              controller.text = _titleController.text;
            }
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: (val) {
                _titleController.text = val;
                if (val.length >= 3) {
                  _checkHistoryStats(val);
                }
              },
              decoration: InputDecoration(
                hintText: 'es. Studiare matematica, Fare la spesa...',
                prefixIcon: const Icon(Icons.task_alt_outlined),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          _titleController.clear();
                          setState(() {
                            _showSuggestions = false;
                            _historyFeedback = null;
                          });
                        },
                      )
                    : null,
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Inserisci un titolo' : null,
              textCapitalization: TextCapitalization.sentences,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSuggestionBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.spaceMd),
      child: CalmCard(
        color: AppColors.primaryLight.withOpacity(0.2),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceXs),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppColors.textOnColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: Text(
                    _historyFeedback!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            if (_suggestedDuration != null) ...[
              const SizedBox(height: AppTheme.spaceSm),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _applySuggestion,
                  icon: const Icon(Icons.check, size: 16),
                  label: Text('Usa $_suggestedDuration minuti'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spaceSm,
                      vertical: AppTheme.spaceXs,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dettagli (opzionale)',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        TextFormField(
          controller: _descController,
          decoration: const InputDecoration(
            hintText: 'Aggiungi note o dettagli...',
            prefixIcon: Icon(Icons.notes_outlined),
          ),
          maxLines: 3,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    return CalmCard(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: AppColors.primary),
              const SizedBox(width: AppTheme.spaceSm),
              Text(
                'Tempo stimato',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceSm,
                  vertical: AppTheme.spaceXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  '$_estimatedDuration min',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: _estimatedDuration.toDouble(),
              min: 5,
              max: 120,
              divisions: 23,
              label: '$_estimatedDuration min',
              onChanged: (val) {
                setState(() => _estimatedDuration = val.round());
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('5 min', style: Theme.of(context).textTheme.bodySmall),
              Text('120 min', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencySection() {
    return CalmCard(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_outlined, color: AppColors.secondary),
              const SizedBox(width: AppTheme.spaceSm),
              Text(
                'Urgenza',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'low',
                label: Text('Bassa'),
                icon: Icon(Icons.sentiment_satisfied, size: 18),
              ),
              ButtonSegment(
                value: 'medium',
                label: Text('Media'),
                icon: Icon(Icons.sentiment_neutral, size: 18),
              ),
              ButtonSegment(
                value: 'high',
                label: Text('Alta'),
                icon: Icon(Icons.warning_amber, size: 18),
              ),
            ],
            selected: {_urgency},
            onSelectionChanged: (Set<String> newSelection) {
              setState(() {
                _urgency = newSelection.first;
              });
            },
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            _getUrgencyDescription(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  String _getUrgencyDescription() {
    switch (_urgency) {
      case 'low':
        return 'Nessuna fretta, falla quando hai tempo';
      case 'medium':
        return 'Importante ma non urgente';
      case 'high':
        return 'Da fare il prima possibile';
      default:
        return '';
    }
  }

  Widget _buildDeadlineSection() {
    return CalmCard(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      onTap: _pickDeadline,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceSm),
            decoration: BoxDecoration(
              color: _deadline != null
                  ? AppColors.accentLight.withOpacity(0.3)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              Icons.event_outlined,
              color: _deadline != null ? AppColors.accent : AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scadenza',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _deadline == null
                      ? 'Nessuna scadenza'
                      : _formatDeadline(_deadline!),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _deadline != null
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (_deadline != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() => _deadline = null);
              },
              color: AppColors.textSecondary,
            )
          else
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textTertiary,
            ),
        ],
      ),
    );
  }

  Future<void> _pickDeadline() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Seleziona scadenza',
      cancelText: 'Annulla',
      confirmText: 'OK',
    );
    if (date != null) {
      setState(() => _deadline = date);
    }
  }

  String _formatDeadline(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    
    if (diff == 0) return 'Oggi';
    if (diff == 1) return 'Domani';
    if (diff < 7) return 'In $diff giorni';
    
    final monthNames = [
      'Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu',
      'Lug', 'Ago', 'Set', 'Ott', 'Nov', 'Dic'
    ];
    return '${date.day} ${monthNames[date.month - 1]} ${date.year}';
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Annulla'),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.check),
                label: const Text('Salva Attività'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = TasksCompanion(
        id: drift.Value(const Uuid().v4()),
        userId: const drift.Value('current_user_id'), // Mock User ID
        title: drift.Value(_titleController.text.trim()),
        description: drift.Value(_descController.text.trim().isNotEmpty 
            ? _descController.text.trim() 
            : null),
        estimatedDuration: drift.Value(_estimatedDuration),
        urgency: drift.Value(_urgency),
        deadline: drift.Value(_deadline),
        createdAt: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      );

      ref.read(taskRepositoryProvider).createTask(task);
      
      context.pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.textOnColor),
              const SizedBox(width: AppTheme.spaceSm),
              const Expanded(child: Text('Attività creata con successo!')),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}
