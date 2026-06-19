import 'dart:io';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                _buildCheck(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: task.done
                              ? AppTheme.textTertiary
                              : AppTheme.textPrimary,
                          decoration: task.done
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        task.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                if (task.photoPath != null && task.photoPath!.isNotEmpty) ...[
                  GestureDetector(
                    onTap: () => _showProofPhoto(context, task.photoPath!),
                    child: Container(
                      width: 34,
                      height: 34,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.border2),
                        image: DecorationImage(
                          image: FileImage(File(task.photoPath!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],

                if (task.tag != null && task.tag!.isNotEmpty)
                  _buildTag(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheck() {
    if (task.done) {
      return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.greenDim,
          border: Border.all(color: AppTheme.green, width: 1.5),
        ),
        child: const Icon(Icons.check, size: 13, color: AppTheme.green),
      );
    }
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.border2, width: 1.5),
      ),
    );
  }

  void _showProofPhoto(BuildContext context, String path) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(path), fit: BoxFit.contain),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag() {
    final bool isDone = task.tagType == 'done';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDone ? AppTheme.greenDim : AppTheme.accentGlow,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: isDone
              ? AppTheme.green.withOpacity(0.2)
              : AppTheme.accent.withOpacity(0.2),
        ),
      ),
      child: Text(
        task.tag ?? '',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isDone ? AppTheme.green : AppTheme.accent2,
        ),
      ),
    );
  }
}