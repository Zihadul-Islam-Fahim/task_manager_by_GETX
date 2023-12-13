import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/CanceledTaskController.dart';
import '../../Data/Modal/TaskListModal.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class CenceledTaskScreen extends StatefulWidget {
  const CenceledTaskScreen({super.key});

  @override
  State<CenceledTaskScreen> createState() => _CenceledTaskScreenState();
}

class _CenceledTaskScreenState extends State<CenceledTaskScreen> {
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
              child: bodyBackground(
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
                          itemCount: taskListModal.TaskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: taskListModal.TaskList![index],
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
