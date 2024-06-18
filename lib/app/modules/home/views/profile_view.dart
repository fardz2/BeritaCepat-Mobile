import 'package:berita_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:berita_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:berita_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileView extends GetView<HomeController> {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.user_login.value
          ? Center(
              child: ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: const Text("Logout")))
          : Center(
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: const Text("Login")))),
    );
  }
}
