import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/utility/Url.dart';
import '../Data/Modal/TaskListModal.dart';
import '../Data/networkCaller/NetworkResponse.dart';

class NewTaskController extends GetxController {

  bool _loading = false;
  TaskListModal _taskListModal = TaskListModal();
  bool get loading => _loading;
  TaskListModal get taskListModal => _taskListModal;

  Future<bool> getNewTaskList() async {
    _loading = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      _taskListModal = TaskListModal.fromJson(response.jsonResponse);
      _loading = false;
      update();
      return true;
    } else {
      return false;
    }
  }
}
