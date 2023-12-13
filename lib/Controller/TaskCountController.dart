import 'package:get/get.dart';
import 'package:task_manager_1/Data/Modal/TaskCountModal.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';

class TaskCountController extends GetxController {
  TaskCountModal taskCountModal = TaskCountModal();

  Future<bool> getTaskCount() async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskCount);
    update();
    if (response.isSuccess) {
      taskCountModal = TaskCountModal.fromJson(response.jsonResponse);
      return true;
    } else {
      return false;
    }
  }
}
