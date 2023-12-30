import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/login_controller.dart';
import 'package:task_manager_1/Screens/email_verification_screen.dart';
import 'package:task_manager_1/Widget/body_background.dart';
import '../Data/utility/email_validator.dart';
import 'reg_screen.dart';
import 'TaskScreens/bottom_nav_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LogInController _logInController = Get.find<LogInController>();

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
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Password!';
                        }
                        return null;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<LogInController>(builder: (controller) {
                      return Visibility(
                        visible: controller.loading == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
                      );
                    }),
                    const SizedBox(
                      height: 28,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(const EmailVerification());
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Din\'t have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'poppins'),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(RegScreen());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'poppins'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    final response = await _logInController.login(
        _emailTEController.text, _passwordTEController.text);

    if (response == true) {
      Get.offAll(const BottomBarScreen());
      Get.snackbar("Login", _logInController.message,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar(
        "Login",
        _logInController.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
