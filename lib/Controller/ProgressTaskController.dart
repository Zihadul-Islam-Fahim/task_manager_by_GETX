import 'package:get/get.dart';
import 'package:task_manager_1/Data/utility/Url.dart';
import '../Data/Modal/TaskListModal.dart';
import '../Data/networkCaller/NetworkCaller.dart';
import '../Data/networkCaller/NetworkResponse.dart';

class ProgressTaskController extends GetxController {

  bool _loading = false;
  bool get loading => _loading;

  TaskListModal _taskListModal = TaskListModal();
  TaskListModal get taskListModal => _taskListModal;

  Future<bool> getProgressTaskList() async {
    _loading = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);

    _loading = false;
    update();

    if (response.isSuccess) {
      _taskListModal = TaskListModal.fromJson(response.jsonResponse);
      return true;
    }
    return false;
  }
}
