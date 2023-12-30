import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/network_caller.dart';
import 'package:task_manager_1/Data/utility/Url.dart';

class ConfirmPassController extends GetxController {
  bool _loading = false;
  String _message = '';
  bool get loading => _loading;
  String get message => _message;

  Future<bool> setPassword(password, email, otp) async {
    _loading = true;
    update();
    var response = await NetworkCaller().postRequest(Urls.setPassword,
        body: {"email": email, "OTP": otp, "password": password.toString()});
    _loading = false;
    update();

    if (response.isSuccess) {
      _message = 'Password Changed,Please Login !!';
      return true;
    } else {
      _message = 'Password Change failed,Try again !!';
      return false;
    }
  }
}
