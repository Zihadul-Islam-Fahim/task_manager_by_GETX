import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/network_caller.dart';
import 'package:task_manager_1/Data/networkCaller/network_response.dart';
import 'package:task_manager_1/Data/utility/Url.dart';

class AddNewTaskController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> createTask(title, description) async {
    _loading = true;
    update();

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.createTask,
      body: {'title': title, 'description': description, 'status': 'New'},
    );

    _loading = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
