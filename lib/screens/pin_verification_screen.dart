import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_1/controllers/pin_verification_controller.dart';
import 'package:task_manager_1/widgets/body_background.dart';
import '../controllers/auth_controller.dart';
import 'confirm_password_screen.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  String pinNumber = '';
  final PinVerifyController _pinVerifyController =
      Get.find<PinVerifyController>();

  onSubmit() async {
    String? email =
        await Get.find<AuthController>().retrieveEmailAndOtp('email');
    Get.find<AuthController>().saveEmailAndOtp('OTP', pinNumber.toString());

    final res = await _pinVerifyController.onSubmit(email, pinNumber);

    if (res == true) {
      Get.snackbar("Accepted", _pinVerifyController.message,
          snackPosition: SnackPosition.BOTTOM);
      Get.to(const ConfirmPassword());
    } else {
      Get.snackbar(
        "Wrong OTP",
        _pinVerifyController.message,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'A 6 digit pin will send to your email Adress',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.slide,
                    pinTheme: PinTheme(
                        fieldHeight: 50,
                        fieldWidth: 50,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(9),
                        activeFillColor: Colors.white),
                    animationDuration: const Duration(milliseconds: 200),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onChanged: (value) {
                      pinNumber = value.toString();
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  GetBuilder<PinVerifyController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.loading == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              onSubmit();
                            },
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
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
    );
  }
}
