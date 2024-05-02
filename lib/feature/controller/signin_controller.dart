import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  //loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }

  clearTextEditingControllers() {
    passwordController.clear();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
