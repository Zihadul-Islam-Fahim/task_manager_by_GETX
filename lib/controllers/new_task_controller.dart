import 'package:get/get.dart';
import 'package:task_manager_1/Data/utility/url.dart';
import '../data/model/task_list_modal.dart';
import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';

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
