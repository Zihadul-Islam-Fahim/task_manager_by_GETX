import 'package:get/get.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';
import 'authController.dart';

class EmailVerityController extends GetxController {

  bool _loading = false;
  String _message = '';
  bool get loading => _loading;
  String get message => _message;

  Future<bool> sendCodeToEmail(email) async {
    _loading = true;
    update();
    Get.find<AuthController>().saveEmailAndOtp('email', email);
    final NetworkResponse response =
        await NetworkCaller().getRequest1(Urls.verifyEmail, email);
    _loading = false;
    update();
    if (response.isSuccess) {
      _message = 'OTP send to your Email';
      return true;
    } else {
      _message = 'Error!! Try Again ';
      return false;
    }
  }
}
