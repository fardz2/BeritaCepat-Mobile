import 'package:berita_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:berita_mobile/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  HomeController homeController = Get.find();
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      await ApiService().login(emailController.text, passwordController.text);
      Get.back();
      Get.snackbar(
        "Login",
        "Login Berhasil",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      homeController.getSatusLoginUser();
    } catch (e) {
      print(e);
    }
  }
}
