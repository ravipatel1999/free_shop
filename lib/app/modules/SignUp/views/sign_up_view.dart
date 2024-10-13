import 'package:eccomerce_app/app/components/TextField/form_text_field.dart';
import 'package:eccomerce_app/app/custom/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../components/TextField/constant/app_color.dart';
import '../../../components/testStyle/input_Style.dart';
import '../controllers/sign_up_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.025),
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: Text(
                        controller.isOtpSent.value
                            ? 'Verify OTP'
                            : 'Sign up to continue',
                        style: AppStyles.loginHeaderStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please enter the OTP to confirm your identity and complete the verification process.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Obx(
                    () => controller.isOtpSent.value
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: PinFieldAutoFill(
                                  cursor: Cursor(
                                    width: 20,
                                    height: 20,
                                    color: Colors.red,
                                    radius: const Radius.circular(1),
                                  ),
                                  decoration: BoxLooseDecoration(
                                    strokeWidth: 0.5,
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    strokeColorBuilder:
                                        const FixedColorBuilder(Colors.grey),
                                    bgColorBuilder: const FixedColorBuilder(
                                        Color.fromARGB(255, 247, 246, 246)),
                                    radius: const Radius.circular(5),
                                  ),
                                  codeLength: 4,
                                  currentCode: controller.code.value,
                                  onCodeChanged: controller.onCodeChanged,
                                ),
                              ),
                              const SizedBox(height: 35),
                            ],
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: controller.selectCountry,
                                child: Container(
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
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.error,
                                                color: Colors.red);
                                          },
                                        ),
                                        const SizedBox(width: 8.0),
                                        Obx(() => Text(
                                              controller.countryCode.value,
                                              style: TextStyle(
                                                color: AppColors.hintColor,
                                              ),
                                            )),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.hintColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomTextFormField(
                                  borderDecoration: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  autofocus: true,
                                  hintText: '10 digit mobile number',
                                  textInputType: TextInputType.phone,
                                  controller: controller.phoneController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (text) {
                                    controller.phoneNumber.value =
                                        text; // Update observable
                                    if (text.length == 10) {
                                      FocusScope.of(context).unfocus();
                                      controller
                                          .sendOtp(); // Automatically send OTP
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                  // const SizedBox(height: 35),
                  Obx(
                    () => controller.isOtpSent.value
                        ? const SizedBox()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => Checkbox(
                                  activeColor: AppColors.primaryColor,
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
                                        text:
                                            'By going forward, you accept our ',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
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
                                          color: AppColors.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policies',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
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
                  ),
                  Obx(() => controller.isOtpSent.value
                      ? Align(
                          alignment: Alignment.center,
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: controller.isButtonVisible.value
                                    ? controller.isOtpSent.value
                                        ? controller.verifyOtp
                                        : controller.sendOtp
                                    : null,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Didn't receive the code? ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            // controller
                                            //             .isButtonVisible.value ==
                                            //         false
                                            //     ? '${controller.remainingSeconds.value}s'
                                            // : (controller.isOtpSent.value
                                            //     ?
                                            "Resend",
                                        // : "Send OTP"),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                // controller.isButtonVisible.value
                                                // ?
                                                AppColors.buttonColor,
                                            // : AppColors.greenColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                // controller.isButtonVisible.value
                                                AppColors.buttonColor
                                            // : AppColors.greenColor,
                                            ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (controller
                                                .isButtonVisible.value) {
                                              controller.isOtpSent.value
                                                  ? controller.verifyOtp()
                                                  : controller.sendOtp();
                                            }
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()),
                  Obx(
                    () => CustomButton(
                      text: controller.isOtpSent.value
                          ? 'Verify OTP'
                          : 'Send OTP',
                      onPressed: () {
                        if (controller.isOtpSent.value) {
                          controller.verifyOtp();
                        } else {
                          controller.sendOtp();
                        }
                      },
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
