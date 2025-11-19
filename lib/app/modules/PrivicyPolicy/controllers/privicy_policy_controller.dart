import 'package:get/get.dart';

class PrivicyPolicyController extends GetxController {
  var currentPolicy = PolicyType.privacy.obs;
  var isLoading = false.obs;

  void changePolicy(PolicyType type) {
    currentPolicy.value = type;
  }

  String getPolicyContent() {
    switch (currentPolicy.value) {
      case PolicyType.privacy:
        return privacyPolicyContent;
      case PolicyType.terms:
        return termsContent;
      case PolicyType.refund:
        return refundContent;
      case PolicyType.disclaimer:
        return disclaimerContent;
      default:
        return privacyPolicyContent;
    }
  }

  String getPolicyTitle() {
    switch (currentPolicy.value) {
      case PolicyType.privacy:
        return "Privacy Policy";
      case PolicyType.terms:
        return "Terms & Conditions";
      case PolicyType.refund:
        return "Refund & Cancellation Policy";
      case PolicyType.disclaimer:
        return "Disclaimer";
      default:
        return "Privacy Policy";
    }
  }
}

enum PolicyType {
  privacy,
  terms,
  refund,
  disclaimer,
}

// Policy Contents
const String privacyPolicyContent = '''
## 1. INTRODUCTION

This Privacy Policy describes how Siara Technology collects, uses, stores, processes, and protects your information when you use the LedgerFace mobile application, web application, website, APIs, or any related services.

## 2. INFORMATION WE COLLECT

### 2.1 PERSONAL INFORMATION
* Full name
* Mobile number
* Email address
* Business name and role
* Address and location-based details

### 2.2 BUSINESS & FINANCIAL INFORMATION
* Ledger entries
* Party-wise balances
* Payment details
* Invoice data
* Bills, challans, statements

We DO NOT store:
* Debit/credit card numbers
* CVV numbers
* ATM PINs
* Net-banking passwords

[Continue with full privacy policy content...]
''';

const String termsContent = '''
## 1. ACCEPTANCE

By accessing LedgerFace, you agree to these Terms, Privacy Policy, and any supplemental guidelines.

## 2. ELIGIBILITY

You must be:
* At least 18 years old
* Capable of entering into legally binding agreements

[Continue with full terms content...]
''';

const String refundContent = '''
## 1. SUBSCRIPTION MODEL

LedgerFace may offer:
* Monthly subscriptions
* Annual subscriptions
* Add-on modules
* Enterprise plans

## 2. REFUND POLICY

✅ Valid Refund Situations:
* Duplicate payment made by the user
* Incorrect billing caused by our system error
* Subscription purchased but service not activated within 7 working days

❌ Refunds NOT provided for:
* Change of mind after purchase
* Misuse of the application
* Wrong entries, incorrect reports, or business losses

[Continue with full refund policy content...]
''';

const String disclaimerContent = '''
## 1. GENERAL DISCLAIMER

LedgerFace is a digital financial management tool. Information generated inside the app depends on user-entered data.

## 2. NO FINANCIAL OR LEGAL ADVICE

LedgerFace does not provide:
* Professional accounting
* Legal consultation
* Tax advisory
* Financial planning

[Continue with full disclaimer content...]
''';
