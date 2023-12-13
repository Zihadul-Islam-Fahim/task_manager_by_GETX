import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/AddNewTaskController.dart';
import 'package:task_manager_1/Controller/NewTaskController.dart';
import 'package:task_manager_1/Screens/TaskScreens/BottomNavScreen.dart';
import 'package:task_manager_1/Widget/ProfileSummaryCard.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileSummeryCard(),
              Expanded(
                child: bodyBackground(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _titleTEController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return ' Enter title';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: 'Title'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return ' Enter Discription';
                              }
                              return null;
                            },
                            maxLines: 8,
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          GetBuilder<AddNewTaskController>(
                            builder: (controller) {
                              return Visibility(
                                visible: controller.loading == false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        createTask();
                                      }
                                    },
                                    child: const Icon(
                                        Icons.arrow_forward_ios_rounded)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    final response = await _addNewTaskController.createTask(
        _titleTEController.text.trim(), _descriptionTEController.text.trim());

    if (response == true) {
      Get.snackbar("Task Created", "", snackPosition: SnackPosition.BOTTOM);
      _titleTEController.clear();
      _descriptionTEController.clear();
      Get.find<NewTaskController>().getNewTaskList();

      Get.offAll(const BottomBar_Screen());
    } else {
      Get.snackbar('Error!!', 'Task Creating Failed!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _titleTEController.dispose();
    super.dispose();
  }
}
