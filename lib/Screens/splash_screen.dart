import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/auth_controller.dart';
import 'package:task_manager_1/Screens/TaskScreens/bottom_nav_screen.dart';
import 'package:task_manager_1/Widget/body_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> goToLoginScreen() async {
    final bool isLoggedIn = await Get.find<AuthController>().checkAuthState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(isLoggedIn ? const BottomBarScreen() : const LogInScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    goToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BodyBackground(
            child: Center(
              child: SvgPicture.asset('asset/images/logo.svg'),
            ),
          )
        ],
      ),
    );
  }
}
