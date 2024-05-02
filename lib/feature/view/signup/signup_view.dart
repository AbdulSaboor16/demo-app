import 'dart:ui';
import 'package:demo_app/core/constants/app_assets.dart';
import 'package:demo_app/core/constants/app_colors.dart';
import 'package:demo_app/core/helper/firebase_service.dart';
import 'package:demo_app/core/helper/validator.dart';
import 'package:demo_app/core/resource/widgets/custom_button.dart';
import 'package:demo_app/core/resource/widgets/custom_text.dart';
import 'package:demo_app/core/resource/widgets/custom_text_field.dart';
import 'package:demo_app/feature/controller/signup_controller.dart';
import 'package:demo_app/feature/view/additional_info/additional_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

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
                  text: "Hi!",
                  color: Colors.white,
                ).paddingOnly(top: Get.height * 0.28, left: 20),
                Container(
                  height: Get.height * 0.6,
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
                              CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    Validator.validateEmail(value ?? ""),
                                hintText: "Email",
                                controller: signUpController.emailController,
                              ).paddingOnly(top: 25),
                              RoundButton(
                                  title: "Continue",
                                  onTap: () async {
                                    String? email =
                                        signUpController.emailController.text;
                                    String? error =
                                        Validator.validateEmail(email ?? "");
                                    if (error == null) {
                                      // bool emailExists =
                                      //     await authenticationService
                                      //         .doesEmailExist(email);
                                      // if (emailExists) {
                                      //   Get.to(() => SignInView(email: email));
                                      // } else {
                                      //   Get.to(() =>
                                      //       AdditionalInfoView(email: email));
                                      //   print(
                                      //       'Email does not exist, handle creating user logic here');
                                      // }
                                      signUpController
                                          .checkEmailAndNavigate(email);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  }).paddingOnly(top: 20, bottom: 20),
                              Row(children: [
                                const Expanded(child: Divider()),
                                const NeoText(
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                  text: "or",
                                  color: Colors.white,
                                ).paddingOnly(right: 20, left: 20),
                                const Expanded(child: Divider())
                              ]),
                              SizedBox(
                                height: Get.height * 0.25,
                                width: double.maxFinite,
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(top: 20),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return RoundButton(
                                              leadingImage: SvgPicture.asset(
                                                  width: 40,
                                                  height: 22,
                                                  signUpController
                                                      .btnImages[index]),
                                              textColor: AppColors.black,
                                              color: AppColors.white,
                                              title: "Continue With Google",
                                              onTap: () {})
                                          .paddingOnly(bottom: 12);
                                    }),
                              ),
                              Row(children: [
                                const NeoText(
                                  fontWeight: FontWeight.w400,
                                  size: 14,
                                  text: "Don't have an account?",
                                  color: Colors.white,
                                ).paddingOnly(right: 5),
                                NeoText(
                                  onClick: () {
                                    Get.to(() => AdditionalInfoView(
                                        email: signUpController
                                            .emailController.text));
                                  },
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                  text: "Sign up",
                                  color: AppColors.primaryAppColor,
                                ),
                              ]),
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
