import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/AddNewTaskController.dart';
import 'package:task_manager_1/Controller/BottomNavController.dart';
import 'package:task_manager_1/Controller/CanceledTaskController.dart';
import 'package:task_manager_1/Controller/CompleteTaskController.dart';
import 'package:task_manager_1/Controller/ConfirmPassController.dart';
import 'package:task_manager_1/Controller/EditProfileController.dart';
import 'package:task_manager_1/Controller/EmailVerifyController.dart';
import 'package:task_manager_1/Controller/LogInController.dart';
import 'package:task_manager_1/Controller/NewTaskController.dart';
import 'package:task_manager_1/Controller/PinVerifyController.dart';
import 'package:task_manager_1/Controller/RegController.dart';
import 'package:task_manager_1/Controller/TaskCountController.dart';
import 'package:task_manager_1/Screens/SplashScreen.dart';
import 'Controller/ProgressTaskController.dart';
import 'Controller/authController.dart';

class TaskManagerApp extends StatelessWidget {
  TaskManagerApp({super.key});

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
          titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
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
