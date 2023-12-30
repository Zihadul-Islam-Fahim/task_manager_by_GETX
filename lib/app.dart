import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/add_task_controller.dart';
import 'package:task_manager_1/Controller/bottom_nav_controller.dart';
import 'package:task_manager_1/Controller/canceled_task_controller.dart';
import 'package:task_manager_1/Controller/completed_task_controller.dart';
import 'package:task_manager_1/Controller/set_pass_controller.dart';
import 'package:task_manager_1/Controller/update_profile_controller.dart';
import 'package:task_manager_1/Controller/email_verification_controller.dart';
import 'package:task_manager_1/Controller/login_controller.dart';
import 'package:task_manager_1/Controller/new_task_controller.dart';
import 'package:task_manager_1/Controller/pin_verification_controller.dart';
import 'package:task_manager_1/Controller/reg_controller.dart';
import 'package:task_manager_1/Controller/task_count_controller.dart';
import 'package:task_manager_1/Screens/splash_screen.dart';
import 'Controller/progress_task_controller.dart';
import 'Controller/auth_controller.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins'),
            bodyMedium: TextStyle(fontSize: 18, fontFamily: 'poppins')),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(380, 45),
            backgroundColor: Colors.green.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(RegController());
    Get.put(LogInController());
    Get.put(EmailVerityController());
    Get.put(PinVerifyController());
    Get.put(ConfirmPassController());
    Get.put(NewTaskController());
    Get.put(TaskCountController());
    Get.put(ProgressTaskController());
    Get.put(CompleteTaskController());
    Get.put(CanceledTaskController());
    Get.put(AddNewTaskController());
    Get.put(EditProfileController());
    Get.put(BottomNavController());
  }
}
