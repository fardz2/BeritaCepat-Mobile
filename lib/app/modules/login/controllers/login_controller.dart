import 'package:berita_mobile/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await ApiService().logout();
    } catch (e) {
      print(e);
    }
  }
}
