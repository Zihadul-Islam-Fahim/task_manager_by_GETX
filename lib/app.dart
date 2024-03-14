import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Screens/splash_screen.dart';
import 'package:task_manager_1/controllers/email_verification_controller.dart';
import 'package:task_manager_1/controllers/set_pass_controller.dart';
import 'package:task_manager_1/controllers/update_profile_controller.dart';
import 'controllers/add_task_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/bottom_nav_controller.dart';
import 'controllers/canceled_task_controller.dart';
import 'controllers/completed_task_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/new_task_controller.dart';
import 'controllers/pin_verification_controller.dart';
import 'controllers/progress_task_controller.dart';
import 'controllers/reg_controller.dart';
import 'controllers/task_count_controller.dart';



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
