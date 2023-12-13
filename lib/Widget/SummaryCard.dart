import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/TaskCountController.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  final count, title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskCountController>(builder: (controller) {
      return Card(
        //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14),side: BorderSide(width: 1,color: Colors.black)),
        elevation: 2,
        child: SizedBox(
          width: Get.width*0.218,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
