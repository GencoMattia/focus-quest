import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/core/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/sync_service.dart';
import 'package:focus_quest/features/gamification/gamification_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Task? _suggestedTask;
  bool _isLoadingSuggestion = false;

  @override
  void initState() {
    super.initState();
    // Trigger Sync on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncData();
    });
  }

  Future<void> _syncData() async {
    // Only sync if supabase is initialized (checked implicitly inside service or could be checked here)
    // For now we just run it. Ideally this would be a provider too.
    try {
       // Quick and dirty manual instantiation for MVP, 
       // in real world use a provider for SyncService
       final db = ref.read(databaseProvider);
       await SyncService(db, Supabase.instance.client).syncPendingChanges();
    } catch (e) {
      // Ignore sync errors on startup
    }
  }

  void _suggestTask(int minutes) async {
    setState(() => _isLoadingSuggestion = true);
    
    // Artificial delay for UX "thinking" feel
    await Future.delayed(const Duration(milliseconds: 800));
    
    final task = await ref.read(quickStartServiceProvider).suggestTask(minutes);
    
    if (mounted) {
      setState(() {
        _suggestedTask = task;
        _isLoadingSuggestion = false;
      });
      
      if (task != null) {
        _showSuggestionDialog(task);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nessuna task urgente per questo lasso di tempo. Rilassati! 🌿')),
        );
      }
    }
  }

  void _showSuggestionDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ecco cosa puoi fare!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            if (task.description != null) Text(task.description!),
            const SizedBox(height: 16),
            Chip(label: Text('${task.estimatedDuration} min')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Magari dopo')),
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.push('/execute-task/${task.id}');
            },
            child: const Text('Inizia Ora 🚀'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuickStartCard(context),
            const SizedBox(height: 16),
            _buildGamificationRow(ref, context),
          ],
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'high': return Colors.redAccent;
      case 'medium': return Colors.orangeAccent;
      case 'low': return Colors.greenAccent;
      default: return Colors.grey;
    }
  }

  Widget _buildGamificationRow(WidgetRef ref, BuildContext context) {
    final streakAsync = ref.watch(currentStreakProvider);
    final badgesAsync = ref.watch(earnedBadgesProvider);

    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   const Text('🔥 Streak', style: TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   streakAsync.when(
                     data: (val) => Text('$val giorni', style: const TextStyle(fontSize: 18, color: AppColors.calmBlue)),
                     loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                     error: (_,__) => const Text('-'),
                   ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
               // Show badges dialog
               badgesAsync.whenData((badges) {
                 showDialog(
                   context: context, 
                   builder: (_) => AlertDialog(
                     title: const Text('I tuoi Traguardi 🏆'),
                     content: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: badges.isEmpty 
                         ? [const Text('Completa delle task per ottenere badge!')] 
                         : badges.map((b) => ListTile(title: Text(b), leading: const Icon(Icons.star, color: Colors.amber))).toList(),
                     ),
                     actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Chiudi'))],
                   )
                 );
               });
            },
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     const Text('🏆 Badge', style: TextStyle(fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     badgesAsync.when(
                       data: (val) => Text('${val.length} ottenuti', style: const TextStyle(fontSize: 18, color: AppColors.calmBlue)),
                       loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                       error: (_,__) => const Text('-'),
                     ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStartCard(BuildContext context) {
    return Card(
      color: AppColors.sageGreen.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.bolt, size: 48, color: AppColors.sageGreen),
            const SizedBox(height: 16),
            Text(
              'Quanto tempo hai adesso?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),
            if (_isLoadingSuggestion)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TimeOptionButton(label: '15 min', minutes: 15, onTap: () => _suggestTask(15)),
                  _TimeOptionButton(label: '30 min', minutes: 30, onTap: () => _suggestTask(30)),
                  _TimeOptionButton(label: '1 h+', minutes: 60, onTap: () => _suggestTask(60)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _TimeOptionButton extends StatelessWidget {
  final String label;
  final int minutes;
  final VoidCallback onTap;

  const _TimeOptionButton({
    required this.label,
    required this.minutes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.sageGreen),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
