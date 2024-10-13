import 'dart:async';

import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final count = 0.0.obs;
  final RxInt _start = 30.obs;
  RxBool isButtonVisible = false.obs;
  Timer? timer;
  int get start => _start.value;
  var isOtpFieldVisible = false.obs;

  String appsignature = "";

  RxString code = ''.obs;
  var countryCode = '+91'.obs; // Default code (observable)
  var flagUrl =
      'https://flagcdn.com/w320/in.png'.obs; // Default flag URL (observable)
  var phoneNumber = ''.obs;
  var errorText = RxnString(); // Nullable reactive string for error text

  final FocusNode phoneFocusNode = FocusNode();

  final Map<String, int> countryPhoneLengths = {
    '+91': 10, // India
    '+92': 10, // Pakistan
    '+1': 10, // USA and Canada
    '+44': 10, // United Kingdom
    '+61': 9, // Australia
    '+49': 11, // Germany
    '+33': 9, // France
    '+39': 10, // Italy
    '+55': 11, // Brazil
    '+52': 10, // Mexico
    '+81': 10, // Japan
    '+86': 11, // China
  };

  final List<Map<String, String>> countries = [
    {'name': 'India', 'code': '+91', 'flag': 'https://flagcdn.com/w320/in.png'},
    {
      'name': 'Pakistan',
      'code': '+92',
      'flag': 'https://flagcdn.com/w320/pk.png'
    },
    {'name': 'USA', 'code': '+1', 'flag': 'https://flagcdn.com/w320/us.png'},
    {
      'name': 'United Kingdom',
      'code': '+44',
      'flag': 'https://flagcdn.com/w320/gb.png'
    },
    {'name': 'Canada', 'code': '+1', 'flag': 'https://flagcdn.com/w320/ca.png'},
    {
      'name': 'Australia',
      'code': '+61',
      'flag': 'https://flagcdn.com/w320/au.png'
    },
    {
      'name': 'Germany',
      'code': '+49',
      'flag': 'https://flagcdn.com/w320/de.png'
    },
    {
      'name': 'France',
      'code': '+33',
      'flag': 'https://flagcdn.com/w320/fr.png'
    },
    {'name': 'Italy', 'code': '+39', 'flag': 'https://flagcdn.com/w320/it.png'},
    {
      'name': 'Brazil',
      'code': '+55',
      'flag': 'https://flagcdn.com/w320/br.png'
    },
    {
      'name': 'Mexico',
      'code': '+52',
      'flag': 'https://flagcdn.com/w320/mx.png'
    },
    {'name': 'Japan', 'code': '+81', 'flag': 'https://flagcdn.com/w320/jp.png'},
    {'name': 'China', 'code': '+86', 'flag': 'https://flagcdn.com/w320/cn.png'},
  ];

  void updateCountryInfo(String phoneNumber) {
    this.phoneNumber.value = phoneNumber;
    errorText.value = null;

    if (phoneNumber.isNotEmpty) {
      String prefix = phoneNumber.substring(
          0, 1); // Adjust this logic for better prefix matching
      for (var country in countries) {
        if (country['code']!.startsWith(prefix)) {
          countryCode.value = country['code']!;
          flagUrl.value = country['flag']!;

          int? expectedLength = countryPhoneLengths[countryCode.value];
          if (expectedLength != null && phoneNumber.length != expectedLength) {
            errorText.value =
                'Invalid phone number length for the selected country.';
          }
          break;
        }
      }
    }
  }

  Future<void> selectCountry() async {
    final selectedCountry = await Get.dialog<Map<String, String>>(
      SimpleDialog(
        title: Text('Select Country'),
        children: countries.map((country) {
          return SimpleDialogOption(
            onPressed: () {
              Get.back(result: country);
            },
            child: Row(
              children: [
                Image.network(country['flag']!, width: 30, height: 20),
                SizedBox(width: 10),
                Text(country['name']!),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selectedCountry != null) {
      countryCode.value = selectedCountry['code']!;
      flagUrl.value = selectedCountry['flag']!;
      updateCountryInfo(
          phoneNumber.value); // Revalidate with the new country code
    }
  }

  TextEditingController phoneController = TextEditingController();
  final otpController = TextEditingController();

  String? verificationId;
  FocusNode focusNode = FocusNode();
  var payload = {"mobileno": ""};
  final formKey = GlobalKey<FormState>();
  var isTermsAccepted = false.obs;
  var isButtonEnabled = false.obs;
  var isOtpSent = false.obs;
  RxInt remainingSeconds = 30.obs;
  final int maxTimerSeconds = 30;
  @override
  void onClose() {
    phoneController.removeListener(checkButtonState);
    phoneController.dispose();
    super.onClose();
  }

  void toggleTermsAcceptance(bool value) {
    isTermsAccepted.value = value;
    checkButtonState();
  }

  void verifyOtp() {
    if (formKey.currentState?.validate() ?? false) {
      Get.toNamed(Routes.BASE);
    }
  }

  void checkButtonState() {
    isButtonEnabled.value = phoneController.text.length == 10 &&
        isTermsAccepted.value &&
        formKey.currentState?.validate() == true;
  }

  void sendOtp() {
    // if (phoneController.text.length == 10) {
    isOtpSent.value = true;
    startTimer();
    // } else {

    // }
  }

  // Start the countdown timer
  void startTimer() {
    isButtonVisible.value = true;
    remainingSeconds.value = maxTimerSeconds; // Reset timer
    timer?.cancel(); // Cancel any previous timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isButtonVisible.value = false; // Hide the button
      }
    });
  }

  void onCodeChanged(String? newCode) {
    code.value = newCode ?? '';
    if (code.value.length == 4) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      verifyOtp();
    }
  }

  String get formattedTime {
    int minutes = _start.value ~/ 60;
    int seconds = _start.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
