import 'package:eccomerce_app/app/modules/PrivicyPolicy/views/policy_content_view_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/privicy_policy_controller.dart';

class TermConditionsView extends GetView {
  const TermConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // ignore: prefer_const_constructors
      body: PolicyContentViewView(
        title: 'Terms & Conditions',
        icon: Icons.description_outlined,
        color: Colors.blue,
        content: termsContent,
      ),
    );
  }
}
