import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_count_controller.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  final count, title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskCountController>(
      builder: (controller) {
        return Card(
          elevation: 2,
          child: SizedBox(
            width: Get.width * 0.218,
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: 'poppins'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
