import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/progress_task_controller.dart';
import '../../Data/Modal/task_list_modal.dart';
import '../../Widget/profile_summary_card.dart';
import '../../Widget/task_card.dart';
import '../../Widget/body_background.dart';

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
              child: BodyBackground(
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
                          itemCount: taskListModal.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: taskListModal.taskList![index],
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
