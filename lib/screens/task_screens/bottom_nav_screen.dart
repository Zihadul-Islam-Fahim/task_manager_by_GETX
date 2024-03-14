import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/controllers/bottom_nav_controller.dart';
import 'package:task_manager_1/screens/task_screens/canceled_task_screen.dart';
import 'package:task_manager_1/screens/task_screens/completed_task_screen.dart';
import 'new_task_screen.dart';
import 'progress_task_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();

  List<Widget> get _screens => const [
        NewTaskScreen(),
        ProgressTaskScreen(),
        CompleteTaskScreen(),
        CanceledTaskScreen(),
      ];

  @override
  void initState() {
    _bottomNavController.backToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(builder: (controller) {
      return Scaffold(
        body: _screens[_bottomNavController.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: controller.selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add_card), label: "New"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.sort_up_circle), label: "Progress"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.checkmark_rectangle),
                label: "Completed"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.multiply_square,
                  size: 24,
                ),
                label: "Canceled"),
          ],
          onTap: (index) {
            _bottomNavController.changeIndex(index);
          },
        ),
      );
    });
  }
}
