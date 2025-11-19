import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class PolicyContentViewView extends GetView {
  final String title;
  final IconData icon;
  final Color color;
  final String content;

  const PolicyContentViewView({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: 20.w,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'LedgerFace - Siara Technology',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Effective Date: 5 September 2025',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Policy Content
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildRichTextContent(content),
            ),
            SizedBox(height: 20.h),
            // Contact Information
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRichTextContent(String content) {
    final lines = content.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('## ')) {
          // Section Header
          return Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
            child: Text(
              line.replaceAll('## ', ''),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          );
        } else if (line.startsWith('* ')) {
          // List item
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.h, right: 8.w),
                  child: Icon(
                    Icons.circle,
                    size: 4.w,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Expanded(
                  child: Text(
                    line.replaceAll('* ', ''),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF374151),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (line.startsWith('✅')) {
          // Positive item
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h, right: 8.w),
                  child: Icon(
                    Icons.check_circle,
                    size: 14.w,
                    color: const Color(0xFF10B981),
                  ),
                ),
                Expanded(
                  child: Text(
                    line.replaceAll('✅', '').trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF065F46),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (line.startsWith('❌')) {
          // Negative item
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h, right: 8.w),
                  child: Icon(
                    Icons.cancel,
                    size: 14.w,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                Expanded(
                  child: Text(
                    line.replaceAll('❌', '').trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF991B1B),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (line.trim().isEmpty) {
          return SizedBox(height: 8.h);
        } else {
          // Regular text
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              line,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF374151),
                height: 1.4,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 12.h),
          _buildContactItem(
            Icons.business,
            'Siara Technology',
          ),
          _buildContactItem(
            Icons.email,
            'sales@siaratechnology.com',
          ),
          _buildContactItem(
            Icons.language,
            'https://siaratechnology.com',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.w,
            color: const Color(0xFF64748B),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
