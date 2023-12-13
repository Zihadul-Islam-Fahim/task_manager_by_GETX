import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';

class EditProfileController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;

  Future<bool> updateProfile(Map<String, dynamic> inputData) async {
    _loading = true;
    update();

    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, body: inputData);
    _loading = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  XFile? _photo;

  XFile? get photo => _photo;

  Future selectPhoto() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    if (image != null) {
      _photo = image;
      update();
    }
  }
}
