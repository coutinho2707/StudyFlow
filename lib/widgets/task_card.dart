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