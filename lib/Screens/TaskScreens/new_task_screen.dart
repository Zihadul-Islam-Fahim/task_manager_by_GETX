import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/new_task_controller.dart';
import 'package:task_manager_1/Controller/task_count_controller.dart';
import 'package:task_manager_1/Data/Modal/task_count_modal.dart';
import 'package:task_manager_1/Screens/TaskScreens/add_new_task.dart';
import '../../Widget/profile_summary_card.dart';
import '../../Widget/summary_card.dart';
import '../../Widget/task_card.dart';
import '../../Widget/body_background.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskCountModal taskCountModal = TaskCountModal();
  final TaskCountController _taskCountController =
      Get.find<TaskCountController>();

  Future<void> getTaskCount() async {
    final response = await _taskCountController.getTaskCount();
    if (response == true) {
      taskCountModal = _taskCountController.taskCountModal;
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCount();
    Get.find<NewTaskController>().getNewTaskList();
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GetBuilder<TaskCountController>(
                          builder: (controller) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: taskCountModal.taskCount?.length ?? 0,
                              itemBuilder: (context, index) {
                                return SummaryCard(
                                    count: taskCountModal.taskCount![index].sum,
                                    title: taskCountModal.taskCount![index].id);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 90,
                      child: GetBuilder<NewTaskController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.loading == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: RefreshIndicator(
                              onRefresh: () => controller.getNewTaskList(),
                              child: ListView.builder(
                                itemCount:
                                    controller.taskListModal.taskList?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  return TaskCard(
                                    task: controller
                                        .taskListModal.taskList![index],
                                    chipColor: Colors.blue,
                                    refresh: controller.getNewTaskList,
                                    getTaskCount: getTaskCount,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewTask());
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
