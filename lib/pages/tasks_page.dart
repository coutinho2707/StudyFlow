import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/task_card.dart';
import '../models/task.dart';
import '../database/database_helper.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final data = await DatabaseHelper.instance.getTasks();
    setState(() {
      tasks = data;
    });
  }

  void toggleTask(Task task) async {
    final updated = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      done: !task.done,
      tag: task.tag,
      tagType: task.tagType,
    );

    await DatabaseHelper.instance.updateTask(updated);
    loadTasks();
  }

  void deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    loadTasks();
  }

  void showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nova Tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) return;

                await DatabaseHelper.instance.insertTask(
                  Task(
                    title: titleController.text,
                    description: descController.text,
                    done: false,
                    tag: "Novo",
                    tagType: "normal",
                  ),
                );

                Navigator.pop(context);
                loadTasks();
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void showEditTaskDialog(Task task) {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) return;

                final updated = Task(
                  id: task.id,
                  title: titleController.text,
                  description: descController.text,
                  done: task.done,
                  tag: task.tag,
                  tagType: task.tagType,
                );

                await DatabaseHelper.instance.updateTask(updated);

                Navigator.pop(context);
                loadTasks();
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = tasks.where((t) => !t.done).toList();
    final done = tasks.where((t) => t.done).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tarefas',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: showAddTaskDialog,
                    child: const Icon(
                      Icons.add,
                      color: AppTheme.accent2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  Text("${pending.length} pendentes"),
                  const SizedBox(height: 10),

                  ...pending.map(
                        (t) => Dismissible(
                      key: Key(t.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => deleteTask(t.id!),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskCard(
                        task: t,
                        onTap: () => toggleTask(t),
                        onLongPress: () => showEditTaskDialog(t),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text("${done.length} concluídas"),
                  const SizedBox(height: 10),

                  ...done.map(
                        (t) => Dismissible(
                      key: Key(t.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => deleteTask(t.id!),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskCard(
                        task: t,
                        onTap: () => toggleTask(t),
                        onLongPress: () => showEditTaskDialog(t),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}