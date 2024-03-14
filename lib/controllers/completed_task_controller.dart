import 'package:get/get.dart';
import 'package:task_manager_1/Data/utility/url.dart';
import '../data/model/task_list_modal.dart';
import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';

class CompleteTaskController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  TaskListModal _taskListModal = TaskListModal();
  TaskListModal get taskListModal => _taskListModal;

  Future<bool> getCompleteTaskList() async {
    _loading = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTask);

    _loading = false;
    update();

    if (response.isSuccess) {
      _taskListModal = TaskListModal.fromJson(response.jsonResponse);
      return true;
    }
    return false;
  }
}
