import 'package:get/get.dart';
import '../Data/utility/Url.dart';
import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';

class RegController extends GetxController {
  bool _loading = false;
  String _message = '';

  bool get loading => _loading;

  String get message => _message;

  Future<bool> signUp(email, fName, lName, mobile, password) async {
    _loading = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, body: {
      "email": email,
      "firstName": fName,
      "lastName": lName,
      "mobile": mobile,
      "password": password,
    });
    _loading = false;
    update();

    if (response.isSuccess) {
      _message = 'Account has been created!';
      return true;
    } else {
      _message = 'Account creation failed!';
      return false;
    }
  }
}
