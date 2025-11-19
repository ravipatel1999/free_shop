import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Default design size
      minTextAdapt: true, // Enable minimum text adaptation
      splitScreenMode: true, // Support different screen sizes
      builder: (_, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text(
              "Contact Us",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                const _ContactMethods(),
                SizedBox(height: 15.h),
                const _LocationSection(),
                SizedBox(height: 15.h),
                const _SocialMediaSection(),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContactMethods extends GetView<ContactController> {
  const _ContactMethods();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            ...controller.contactMethods
                .map((method) => _ContactTile(method: method)),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final ContactMethod method;

  const _ContactTile({required this.method});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          method.icon,
          color: Theme.of(context).colorScheme.primary,
          size: 18.w,
        ),
      ),
      title: Text(
        method.title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        method.subtitle,
        style: TextStyle(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14.w,
      ),
      onTap: method.action,
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
    );
  }
}

class _LocationSection extends GetView<ContactController> {
  const _LocationSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Our Location",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            _InfoRow(
              icon: Icons.business,
              text: controller.branchInfo.name,
            ),
            SizedBox(height: 12.h),
            _InfoRow(
              icon: Icons.location_on,
              text: controller.branchInfo.address,
            ),
            SizedBox(height: 12.h),
            _InfoRow(
              icon: Icons.access_time,
              text: controller.branchInfo.hours,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: controller.openMaps,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      "Open in Maps",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16.w,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialMediaSection extends GetView<ContactController> {
  const _SocialMediaSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Follow Us",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.socialMedia
                  .map((social) => _SocialIcon(social: social))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends GetView<ContactController> {
  final SocialMedia social;

  const _SocialIcon({required this.social});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.launchUrl(social.url),
      icon: Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Icon(
          social.icon,
          size: 20.w,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
