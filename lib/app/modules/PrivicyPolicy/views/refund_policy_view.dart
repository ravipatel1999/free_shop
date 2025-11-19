import 'package:eccomerce_app/app/modules/PrivicyPolicy/views/policy_content_view_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/privicy_policy_controller.dart';

class RefundPolicyView extends GetView {
  const RefundPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Refund Policy',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const PolicyContentViewView(
        title: 'Refund & Cancellation Policy',
        icon: Icons.payment_outlined,
        color: Colors.orange,
        content: refundContent,
      ),
    );
  }
}
