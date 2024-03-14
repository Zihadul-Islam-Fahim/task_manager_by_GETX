import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/controllers/completed_task_controller.dart';
import 'package:task_manager_1/data/model/task_list_modal.dart';
import 'package:task_manager_1/widgets/body_background.dart';
import 'package:task_manager_1/widgets/profile_summary_card.dart';
import 'package:task_manager_1/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool loading = false;
  TaskListModal _taskListModal = TaskListModal();
  final CompleteTaskController _completeTaskController =
      Get.find<CompleteTaskController>();

  Future<void> getCompleteTaskList() async {
    final response = await _completeTaskController.getCompleteTaskList();
    if (response == true) {
      _taskListModal = _completeTaskController.taskListModal;
    }
  }

  @override
  void initState() {
    super.initState();
    getCompleteTaskList();
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
                child: GetBuilder<CompleteTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.loading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: getCompleteTaskList,
                        child: ListView.builder(
                          itemCount: _taskListModal.taskList?.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: _taskListModal.taskList![index],
                              chipColor: Colors.green,
                              refresh: getCompleteTaskList,
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
