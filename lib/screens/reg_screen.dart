import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Screens/login_screen.dart';
import 'package:task_manager_1/controllers/reg_controller.dart';
import 'package:task_manager_1/widgets/body_background.dart';
import '../Data/utility/email_validator.dart';

class RegScreen extends StatefulWidget {
  RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegController _regController = Get.find<RegController>();

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
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "First Name",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.length != 11) {
                          return "Mobile No must be 11 digit";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Mobile",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        } else if (value!.length < 6) {
                          return 'Password more than 6 letters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<RegController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.loading == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed: () => signUp(),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'poppins'),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Sign in',
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

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      final response = await _regController.signUp(
          _emailController.text.trim(),
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _mobileController.text,
          _passwordController.text);
      if (mounted) {}
      if (response == true) {
        Get.snackbar("Log in please!", _regController.message,
            snackPosition: SnackPosition.BOTTOM);
        clearTextField();
        Get.offAll(const LogInScreen());
      } else {
        Get.snackbar(
          "Sign Up Failed",
          _regController.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void clearTextField() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
