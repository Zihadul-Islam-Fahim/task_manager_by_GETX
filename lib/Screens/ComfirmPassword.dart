import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/ConfirmPassController.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Screens/LogInScreen.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController cPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ConfirmPassController _confirmPassController =
      Get.find<ConfirmPassController>();

  setPassword(password) async {
    String email =
        await Get.find<AuthController>().retrieveEmailAndOtp('email');
    String otp = await Get.find<AuthController>().retrieveEmailAndOtp('OTP');

    var response =
        await _confirmPassController.setPassword(password, email, otp);
    if (response == true) {
      Get.snackbar("Scccess", _confirmPassController.message,
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(const LogInScreen());
    } else {
      Get.snackbar(
        "Failed",
        _confirmPassController.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordTEController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' Enter Password';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "New Password"),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: cPasswordTEController,
                      validator: (String? value) {
                        if (value != passwordTEController.text) {
                          return 'Password should be same..';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Confirm Password"),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<ConfirmPassController>(builder: (controller) {
                      return Visibility(
                        visible: controller.loading == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setPassword(cPasswordTEController.text);
                              }
                            },
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
