import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/NewTaskController.dart';
import 'package:task_manager_1/Controller/TaskCountController.dart';
import 'package:task_manager_1/Data/Modal/TaskCountModal.dart';
import 'package:task_manager_1/Screens/TaskScreens/AddNewTask.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/SummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

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
              child: bodyBackground(
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
                                    controller.taskListModal.TaskList?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  return TaskCard(
                                    task: controller
                                        .taskListModal.TaskList![index],
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
