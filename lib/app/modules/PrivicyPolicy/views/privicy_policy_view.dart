import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/privicy_policy_controller.dart';
import 'policy_content_view_view.dart';

class PrivicyPolicyView extends StatelessWidget {
  const PrivicyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const PolicyContentViewView(
        title: 'Privacy Policy',
        icon: Icons.privacy_tip_outlined,
        color: Colors.purple,
        content: privacyPolicyContent,
      ),
    );
  }
}
