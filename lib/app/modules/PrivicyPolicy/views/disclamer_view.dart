import 'package:eccomerce_app/app/modules/PrivicyPolicy/views/policy_content_view_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/privicy_policy_controller.dart';

class DisclamerView extends GetView {
  const DisclamerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disclaimer',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const PolicyContentViewView(
        title: 'Disclaimer',
        icon: Icons.warning_amber_outlined,
        color: Colors.red,
        content: disclaimerContent,
      ),
    );
  }
}
