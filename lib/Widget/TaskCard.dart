import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import '../Data/Modal/Task.dart';
import '../Data/utility/Url.dart';

enum taskStatus { New, Progress, Completed, Canceled }

class TaskCard extends StatefulWidget {
  final Task task;
  final chipColor;
  final VoidCallback refresh;
  VoidCallback? getTaskCount;

  TaskCard({
    super.key,
    required this.task,
    required this.chipColor,
    required this.refresh,
    this.getTaskCount,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  deleteTasks() async {
    final response =
        await NetworkCaller().getRequest(Urls.deleteTask(widget.task.sId));

    if (response.isSuccess) {
      Get.snackbar('Delete Success', '', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Delete Failed!', '',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
    widget.refresh();
    widget.getTaskCount!();
  }

  updateTaskStatus(String status) async {
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId, status));
    widget.refresh();
    widget.getTaskCount!();
    if (response.isSuccess) {
      Get.snackbar('Status Updated', '', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar(
        'Status Update failed..',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            ),
            Text(
              widget.task.description ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            Text(
              'Date : ${widget.task.createdDate ?? ''}',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.grey.shade700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.chipColor,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModal();
                      },
                      icon: Icon(Icons.edit_note_outlined),
                    ),
                    IconButton(
                        onPressed: () {
                          ShowModalforDelete();
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void ShowModalforDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete !!!'),
          content: const Text('Are You want to delete?'),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    )),
                TextButton(
                  onPressed: () {
                    deleteTasks();
                    Get.back();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  showUpdateStatusModal() {
    List<ListTile> items = taskStatus.values
        .map(
          (e) => ListTile(
            onTap: () {
              updateTaskStatus(e.name);
              Get.back();
            },
            title: Text(e.name),
          ),
        )
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
