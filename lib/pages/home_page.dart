import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../database/database_helper.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../services/photo_service.dart';
import '../widgets/word_lookup_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadTasks();
  }

  void loadTasks() async {
    final data = await DatabaseHelper.instance.getTasks();
    setState(() {
      tasks = data;
    });
  }

  Future<void> _toggleTask(Task t) async {
    if (!t.done) {
      final photoPath = await PhotoService.captureProofPhoto(t.id!);
      if (photoPath == null) return;

      await DatabaseHelper.instance.updateTask(Task(
        id: t.id,
        title: t.title,
        description: t.description,
        done: true,
        tag: t.tag,
        tagType: t.tagType,
        photoPath: photoPath,
      ));
    } else {
      await PhotoService.deleteProofPhoto(t.photoPath);
      await DatabaseHelper.instance.updateTask(Task(
        id: t.id,
        title: t.title,
        description: t.description,
        done: false,
        tag: t.tag,
        tagType: t.tagType,
        photoPath: null,
      ));
    }
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    int total = tasks.length;
    int done = tasks.where((t) => t.done).length;
    int pending = tasks.where((t) => !t.done).length;

    double progress = total == 0 ? 0 : done / total;

    final nextTasks =
    tasks.where((t) => !t.done).take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Olá, Gabriel",
                style: TextStyle(
                  fontSize: 24,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Progresso de estudos",
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${(progress * 100).toInt()}%",
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      title: "Matérias ativas",
                      value: "$total",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      title: "Tarefas feitas",
                      value: "$done",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () => showWordLookupDialog(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.accentGlow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: AppTheme.accent2,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Caixa de dúvidas",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Tem dúvida sobre uma palavra? Toque para buscar.",
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppTheme.textTertiary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Próximas tarefas",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (nextTasks.isEmpty)
                const Text(
                  "Nenhuma tarefa pendente 🎉",
                  style: TextStyle(color: AppTheme.textSecondary),
                ),

              ...nextTasks.map((t) => TaskCard(
                task: t,
                onTap: () => _toggleTask(t),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}