import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/ProgressTaskController.dart';
import '../../Data/Modal/TaskListModal.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();
  TaskListModal taskListModal = TaskListModal();

  Future<void> getProgressTaskList() async {
    final response = await _progressTaskController.getProgressTaskList();
    if (response == true) {
      taskListModal = _progressTaskController.taskListModal;
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: bodyBackground(
                child: GetBuilder<ProgressTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.loading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: getProgressTaskList,
                        child: ListView.builder(
                          itemCount: taskListModal.TaskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: taskListModal.TaskList![index],
                              chipColor: Colors.purple,
                              refresh: getProgressTaskList,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
