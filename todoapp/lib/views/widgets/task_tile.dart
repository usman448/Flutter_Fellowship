import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modals/task_modal.dart';
import 'package:todoapp/viewmodals/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;

  TaskTile({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: task.isCompleted ? Color(0xFFE94560).withOpacity(0.4) : Color(0xFF0F3460),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
            taskProvider.toggleTask(index);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            color: task.isCompleted ? Colors.white38 : Colors.white,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Color(0xFFE94560),
            fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 11, color: Colors.white38),
              SizedBox(width: 4),
              Text(
                _formatTime(task.createdAt),
                style: TextStyle(fontSize: 11, color: Colors.white38),
              ),
              if (task.isCompleted) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Color(0xFFE94560).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Done', style: TextStyle(fontSize: 10, color: Color(0xFFE94560))),
                ),
              ],
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red.shade300, size: 20),
          onPressed: () {
            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
            taskProvider.deleteTask(index);
          },
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final min = time.minute.toString().padLeft(2, '0');
    return '$hour:$min  ${time.day}/${time.month}/${time.year}';
  }
}
