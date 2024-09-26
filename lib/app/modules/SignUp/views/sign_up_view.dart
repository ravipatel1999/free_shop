import 'package:eccomerce_app/app/components/TextField/form_text_field.dart';
import 'package:eccomerce_app/app/custom/button.dart';
import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../components/TextField/constant/app_color.dart';
import '../../../components/testStyle/textStyle.dart';
import '../../../core/utils/validation_functions.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: true,
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 50.0),
                  child: Text(
                    'Sign up to continue',
                    style: CustomTextStyles.headline2,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Row(
                  children: [
                    GestureDetector(
                      onTap: controller.selectCountry,
                      child: Container(
                        // height: ,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 11, horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                controller.flagUrl.value,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error,
                                      color: Colors.red);
                                },
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                controller.countryCode.value,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[500],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.blackColor,
                            width: 1,
                          ),
                        ),
                        autofocus: true,
                        hintText: '10 digit mobile number',
                        textInputType: TextInputType.phone,
                        controller: controller.phoneController,
                        validator: (value) {
                          if (!isValidPhone(value)) {
                            return "Enter a valid  phone number";
                          }
                          return null;
                        },
                        focusNode: controller.focusNode,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (text) {
                          if (text.length == 10) {
                            FocusScope.of(context).unfocus();

                            controller.checkButtonState();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Checkbox(
                        activeColor: AppColors.buttonColor,
                        value: controller.isTermsAccepted.value,
                        onChanged: (bool? value) {
                          if (value != null) {
                            controller.toggleTermsAcceptance(value);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'By going forward, you accept our ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {},
                            ),
                            const TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policies',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => CustomButton(
                      text: 'Sent OTP',
                      onPressed: controller.isButtonEnabled.value
                          ? () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                Get.toNamed(Routes.BASE);
                              }
                            }
                          : () {
                              Get.toNamed(Routes.BASE);
                            },
                      color: controller.isButtonEnabled.value
                          ? AppColors.buttonColor
                          : const Color(0xFFC2BFC0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
