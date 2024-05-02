import 'dart:ui';
import 'package:demo_app/core/constants/app_assets.dart';
import 'package:demo_app/core/constants/app_colors.dart';
import 'package:demo_app/core/helper/firebase_service.dart';
import 'package:demo_app/core/resource/widgets/custom_button.dart';
import 'package:demo_app/core/resource/widgets/custom_text.dart';
import 'package:demo_app/core/resource/widgets/custom_text_field.dart';
import 'package:demo_app/feature/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInView extends StatelessWidget {
  String email;
  SignInView({super.key, required this.email});

  SignInController signInController = Get.put(SignInController());
  AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.bgAsset), fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const NeoText(
                  fontWeight: FontWeight.bold,
                  size: 36,
                  text: "Log in",
                  color: Colors.white,
                ).paddingOnly(top: Get.height * 0.28, left: 20),
                Container(
                  height: Get.height * 0.37,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: Get.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage(AppAssets.bgAsset),
                                ),
                                title: const NeoText(
                                  fontWeight: FontWeight.bold,
                                  size: 16,
                                  text: "Jane Dow",
                                  color: AppColors.white,
                                ),
                                subtitle: NeoText(
                                  fontWeight: FontWeight.w400,
                                  size: 13,
                                  text: email,
                                  color: AppColors.white,
                                ),
                              ),
                              Obx(
                                () => CustomTextField(
                                  obscureText:
                                      signInController.obscureText.value,
                                  hintText: "Password",
                                  controller:
                                      signInController.passwordController,
                                  suffixIcon: NeoText(
                                    onClick: signInController.toggleObscureText,
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    text: signInController.obscureText.value
                                        ? "View"
                                        : "Hide",
                                    color: AppColors.black,
                                  ).paddingOnly(top: 12),
                                ).paddingOnly(top: 25),
                              ),
                              RoundButton(
                                title: "Continue",
                                onTap: () {
                               
                                  authenticationService
                                      .login(
                                          context,
                                          email,
                                          signInController
                                              .passwordController.text)
                                      .then((_) => signInController
                                          .clearTextEditingControllers());
                                },
                              ).paddingOnly(top: 20, bottom: 20),
                              const SizedBox(height: 20),
                              const NeoText(
                                fontWeight: FontWeight.bold,
                                size: 16,
                                text: "Forgot your password?",
                                color: AppColors.primaryAppColor,
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 20)),
                    ),
                  ),
                ),
              ],
            )));
  }
}
