import 'dart:ui';
import 'package:demo_app/core/constants/app_assets.dart';
import 'package:demo_app/core/constants/app_colors.dart';
import 'package:demo_app/core/helper/firebase_service.dart';
import 'package:demo_app/core/resource/widgets/custom_button.dart';
import 'package:demo_app/core/resource/widgets/custom_text.dart';
import 'package:demo_app/core/resource/widgets/custom_text_field.dart';
import 'package:demo_app/feature/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalInfoView extends StatelessWidget {
  String email;
  AdditionalInfoView({super.key, required this.email});

  SignUpController signUpController = Get.put(SignUpController());
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
                  text: "Sign up",
                  color: Colors.white,
                ).paddingOnly(top: Get.height * 0.28, left: 20),
                Container(
                  height: Get.height * 0.45,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: Get.height * 0.02,
                      bottom: Get.height * 0.02),
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
                              const SizedBox(height: 20),
                              const NeoText(
                                fontWeight: FontWeight.w200,
                                size: 14,
                                text:
                                    "Looks like you don't have an account,\nLet's create a new account for",
                                color: Colors.white,
                              ),
                              NeoText(
                                fontWeight: FontWeight.bold,
                                size: 14,
                                text: email,
                                color: Colors.white,
                              ),
                              CustomTextField(
                                hintText: "Name",
                                controller: signUpController.nameController,
                              ).paddingOnly(top: 25),
                              CustomTextField(
                                hintText: "Password",
                                suffixIcon: const NeoText(
                                  fontWeight: FontWeight.bold,
                                  size: 16,
                                  text: "View",
                                  color: AppColors.black,
                                ).paddingOnly(top: 12),
                                controller: signUpController.passwordController,
                              ).paddingOnly(top: 15, bottom: 20),
                              const NeoText(
                                fontWeight: FontWeight.w400,
                                size: 14,
                                text: "By selecting Agree and continue below,",
                                color: Colors.white,
                              ).paddingOnly(right: 5),
                              const Row(children: [
                                NeoText(
                                  fontWeight: FontWeight.w400,
                                  size: 14,
                                  text: "I agree to ",
                                  color: Colors.white,
                                ),
                                NeoText(
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                  text: "Term of Service and Privacy Policy",
                                  color: AppColors.primaryAppColor,
                                ),
                              ]),
                              RoundButton(
                                loading: signUpController.isLoading.value,
                                title: "Agree and Continue",
                                onTap: () async {
                                  signUpController.setLoading(true);
                                  try {
                                    await authenticationService
                                        .createUserIfNotExist(
                                      email,
                                      signUpController.nameController.text,
                                      signUpController.passwordController.text,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('User created successfully'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Failed to create user: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } finally {
                                    signUpController.setLoading(false);
                                  }
                                },
                              ).paddingOnly(top: 20, bottom: 20),
                            ],
                          ).paddingSymmetric(horizontal: 20)),
                    ),
                  ),
                ),
              ],
            )));
  }
}
