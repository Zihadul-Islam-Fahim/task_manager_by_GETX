import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/controllers/canceled_task_controller.dart';
import 'package:task_manager_1/data/model/task_list_modal.dart';
import 'package:task_manager_1/widgets/body_background.dart';
import 'package:task_manager_1/widgets/profile_summary_card.dart';
import 'package:task_manager_1/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  TaskListModal taskListModal = TaskListModal();
  final CanceledTaskController _canceledTaskController =
      Get.find<CanceledTaskController>();

  Future<void> getCanceledTaskList() async {
    final response = await _canceledTaskController.getCanceledTaskList();
    if (response == true) {
      taskListModal = _canceledTaskController.taskListModal;
    }
  }

  @override
  void initState() {
    super.initState();
    getCanceledTaskList();
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
                child: GetBuilder<CanceledTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.loading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: getCanceledTaskList,
                        child: ListView.builder(
                          itemCount: taskListModal.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: taskListModal.taskList![index],
                              chipColor: Colors.red,
                              refresh: getCanceledTaskList,
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
