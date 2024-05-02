import 'package:demo_app/core/constants/app_assets.dart';
import 'package:demo_app/core/helper/firebase_service.dart';
import 'package:demo_app/feature/view/additional_info/additional_info_view.dart';
import 'package:demo_app/feature/view/signin/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List btnImages = [AppAssets.facebook, AppAssets.google, AppAssets.apple];

  // check if email exist
  Future<void> checkEmailAndNavigate(String email) async {
    bool emailExists = await _authenticationService.doesEmailExist(email);
    if (emailExists) {
      Get.to(() => SignInView(email: email));
    } else {
      Get.to(() => AdditionalInfoView(email: email));
    }
  }

   // Variable to hold the loading state
  var isLoading = false.obs;

  // Method to set the loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
