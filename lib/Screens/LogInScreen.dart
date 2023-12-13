import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/LogInController.dart';
import 'package:task_manager_1/Screens/EmailVerification.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import '../Data/utility/Validator.dart';
import 'RegScreen.dart';
import 'TaskScreens/BottomNavScreen.dart';

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
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Learn With Zihadul Islam',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: "Email"),
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
                      decoration: const InputDecoration(hintText: "Password"),
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
                      height: 48,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Get.to(const EmailVerification());
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(RegScreen());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.green),
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
      Get.offAll(const BottomBar_Screen());
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
