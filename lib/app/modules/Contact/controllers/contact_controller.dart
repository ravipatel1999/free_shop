import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../../services/toast_service.dart';

class ContactController extends GetxController {
  late final contactMethods = [
    ContactMethod(
      icon: Icons.email,
      title: "Email Support",
      subtitle: "Get response within 24 hours",
      action: () => launchUrl('mailto:support@company.com'),
    ),
    ContactMethod(
      icon: Icons.chat,
      title: "Live Chat",
      subtitle: "Instant help available",
      action: () => ApptoastUtils.showInfo('Connecting you with support...'),
    ),
    ContactMethod(
      icon: Icons.phone,
      title: "Call Us",
      subtitle: "Mon-Fri: 9AM - 6PM",
      action: () => launchUrl('tel:+1234567890'),
    ),
  ];

  final socialMedia = [
    SocialMedia(icon: Icons.facebook_outlined, url: 'https://facebook.com'),
    SocialMedia(icon: Icons.chat_bubble_outline, url: 'https://wa.me/'),
    SocialMedia(icon: Iconsax.instagram, url: 'https://instagram.com'),
  ];

  final branchInfo = BranchInfo(
    name: "Main Office",
    address: "C55, 1st Floor, Sector-2, Noida, UP",
    hours: "Mon-Fri: 9AM - 5PM | Sat: 10AM - 2PM",
  );

  Future<void> launchUrl(String url) async {
    try {
      if (await url_launcher.canLaunchUrl(Uri.parse(url))) {
        await url_launcher.launchUrl(Uri.parse(url));
      }
    } catch (e) {
      ApptoastUtils.showError('Could not launch $url');
    }
  }

  void openMaps() {
    final url =
        "https://maps.google.com/?q=${Uri.encodeComponent(branchInfo.address)}";
    launchUrl(url);
  }
}

class ContactMethod {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback action;

  ContactMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.action,
  });
}

class BranchInfo {
  final String name;
  final String address;
  final String hours;

  BranchInfo({
    required this.name,
    required this.address,
    required this.hours,
  });
}

class SocialMedia {
  final IconData icon;
  final String url;

  SocialMedia({
    required this.icon,
    required this.url,
  });
}
