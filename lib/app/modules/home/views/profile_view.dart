import 'package:berita_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileView extends GetView {
  ProfileView({Key? key}) : super(key: key);
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text("Logout"))),
    );
  }
}
