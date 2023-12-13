import 'package:get/get.dart';
import 'package:task_manager_1/Data/Modal/TaskListModal.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';

class CanceledTaskController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  TaskListModal _taskListModal = TaskListModal();
  TaskListModal get taskListModal => _taskListModal;

  Future<bool> getCanceledTaskList() async {
    _loading = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getCanceledTask);

    _loading = false;
    update();

    if (response.isSuccess) {
      _taskListModal = TaskListModal.fromJson(response.jsonResponse);
      return true;
    }
    return false;
  }
}
