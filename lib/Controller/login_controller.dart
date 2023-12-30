import 'package:get/get.dart';
import '../Data/Modal/user_modal.dart';
import '../Data/networkCaller/network_caller.dart';
import '../Data/networkCaller/network_response.dart';
import '../Data/utility/url.dart';
import 'auth_controller.dart';

class LogInController extends GetxController {
  bool _loading = false;
  String _message = '';

  bool get loading => _loading;

  String get message => _message;

  Future<bool> login(String email, String password) async {
    _loading = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {'email': email, 'password': password}, isLogin: true);
    _loading = false;
    update();

    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      _message = "Login Success!";
      return true;
    } else {
      if (response.statusCode == 401) {
        _message = 'Email or Password incorrect!';
      } else {
        _message = 'Log in Failed,try again';
      }
      return false;
    }
  }
}
