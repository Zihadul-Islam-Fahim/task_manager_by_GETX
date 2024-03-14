import 'package:get/get.dart';
import 'package:task_manager_1/Data/utility/url.dart';
import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';

class PinVerifyController extends GetxController {
  bool _loading = false;
  String _message = '';

  bool get loading => _loading;

  String get message => _message;

  Future<bool> onSubmit(email, pinNumber) async {
    _loading = true;
    update();
    NetworkResponse res = await NetworkCaller()
        .getRequest1(Urls.verifyOTP, email, otp: pinNumber);
    _loading = false;
    update();

    if (res.isSuccess) {
      _message = 'OTP Accepted';
      return true;
    } else {
      _message = 'Enter the correct OTP';
      return false;
    }
  }
}
