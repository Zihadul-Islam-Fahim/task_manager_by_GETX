import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/email_verification_controller.dart';
import 'package:task_manager_1/Controller/auth_controller.dart';
import 'package:task_manager_1/Data/utility/email_validator.dart';
import 'package:task_manager_1/Screens/pin_verification_screen.dart';
import 'package:task_manager_1/Widget/body_background.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerityController _emailVerityController =
      Get.find<EmailVerityController>();

  Future<void> sendCodeToEmail() async {
    String? email = _emailController.text.trim();
    Get.find<AuthController>().saveEmailAndOtp('email', email);
    final response = await _emailVerityController.sendCodeToEmail(email);
    if (response == true) {
      Get.snackbar("Code Sent to your Mail", _emailVerityController.message,
          snackPosition: SnackPosition.BOTTOM);
      Get.to(const PinVerification());
    } else {
      Get.snackbar(
        "Code Sent Error,Try again!!",
        _emailVerityController.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
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
                      'Your Email Adress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'A 6 digit verification pin will send to your email address',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontFamily: 'poppins'),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<EmailVerityController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.loading == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sendCodeToEmail();
                                }
                              },
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
