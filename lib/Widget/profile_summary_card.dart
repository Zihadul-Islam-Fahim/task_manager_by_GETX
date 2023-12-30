import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/Controller/auth_controller.dart';
import 'package:task_manager_1/Screens/edit_profile_screen.dart';
import 'package:task_manager_1/Screens/login_screen.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({super.key, this.ignoreOnTap = true});

  final bool ignoreOnTap;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      String base64String = AuthController.user!.photo ?? '';

      if (base64String.startsWith('data:image')) {
        // Remove data URI prefix if present
        base64String =
            base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      }

      Uint8List imageBytes = const Base64Decoder().convert(base64String);

      return ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        onTap: () {
          if (widget.ignoreOnTap) {
            Get.to(EditProfileScreen(
              user: AuthController.user,
            ));
          }
        },
        tileColor: Colors.green,
        leading: CircleAvatar(
          radius: 25,
          child: AuthController.user!.photo == null
              ? const Icon(Icons.person)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        title: Text(
          fullname,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'poppins'),
        ),
        subtitle: Text(
          AuthController.user?.email ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: IconButton(
            onPressed: () {
              showModalForLogout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            )),
      );
    });
  }

  String get fullname {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }

  showModalForLogout() {
    Get.defaultDialog(
      title: 'Logout !!!',
      titleStyle: const TextStyle(fontFamily: 'poppins'),
      content: const Text(
        'Are You want to Logout?',
        style: TextStyle(fontFamily: 'poppins'),
      ),
      actions: [
        ButtonBar(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                )),
            TextButton(
              onPressed: () async {
                await Get.find<AuthController>().clearAuthData();
                Get.offAll(const LogInScreen());
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontFamily: 'poppins'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
