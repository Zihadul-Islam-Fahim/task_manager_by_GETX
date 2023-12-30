import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/network_caller.dart';
import 'package:task_manager_1/Data/utility/url.dart';
import '../Data/Modal/task_list_modal.dart';
import '../Data/networkCaller/network_response.dart';

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
