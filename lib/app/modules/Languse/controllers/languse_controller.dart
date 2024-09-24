import 'package:get/get.dart';

class LanguseController extends GetxController {
  RxString selectedLanguage = 'English (UK)'.obs;

  // Make languages reactive by using RxList
  RxList<Map<String, String>> languages = [
    {
      'language': 'English (UK)',
      'flag': 'https://flagcdn.com/w320/gb.png',
      'translation': '(English)'
    },
    {
      'language': 'Egypt (Syria)',
      'flag': 'https://flagcdn.com/w320/eg.png',
      'translation': '(العربية)'
    },
    {
      'language': 'India',
      'flag': 'https://flagcdn.com/w320/in.png',
      'translation': '(हिंदी)'
    },
    {
      'language': 'Pakistan',
      'flag': 'https://flagcdn.com/w320/pk.png',
      'translation': '(اردو)'
    },
    {
      'language': 'Bangladesh',
      'flag': 'https://flagcdn.com/w320/bd.png',
      'translation': '(বাংলাদেশ)'
    },
    {
      'language': 'Philippines',
      'flag': 'https://flagcdn.com/w320/ph.png',
      'translation': '(Tagalog)'
    },
    {
      'language': 'Iran',
      'flag': 'https://flagcdn.com/w320/ir.png',
      'translation': '(فارسی)'
    },
    {
      'language': 'Nepal',
      'flag': 'https://flagcdn.com/w320/np.png',
      'translation': '(नेपाल)'
    },
    {
      'language': 'Sri Lanka (Sinhala)',
      'flag': 'https://flagcdn.com/w320/lk.png',
      'translation': '(සිංහල)'
    },
    {
      'language': 'United States (Tamil)',
      'flag': 'https://flagcdn.com/w320/us.png',
      'translation': '(தமிழ்)'
    },
    {
      'language': 'China',
      'flag': 'https://flagcdn.com/w320/cn.png',
      'translation': '(中文)'
    },
    {
      'language': 'Japan',
      'flag': 'https://flagcdn.com/w320/jp.png',
      'translation': '(日本語)'
    },
    {
      'language': 'Germany',
      'flag': 'https://flagcdn.com/w320/de.png',
      'translation': '(Deutsch)'
    },
    {
      'language': 'France',
      'flag': 'https://flagcdn.com/w320/fr.png',
      'translation': '(Français)'
    },
    {
      'language': 'Spain',
      'flag': 'https://flagcdn.com/w320/es.png',
      'translation': '(Español)'
    },
    {
      'language': 'Russia',
      'flag': 'https://flagcdn.com/w320/ru.png',
      'translation': '(Русский)'
    },
    {
      'language': 'Brazil',
      'flag': 'https://flagcdn.com/w320/br.png',
      'translation': '(Português)'
    },
    {
      'language': 'South Korea',
      'flag': 'https://flagcdn.com/w320/kr.png',
      'translation': '(한국어)'
    },
    {
      'language': 'Italy',
      'flag': 'https://flagcdn.com/w320/it.png',
      'translation': '(Italiano)'
    },
    {
      'language': 'Turkey',
      'flag': 'https://flagcdn.com/w320/tr.png',
      'translation': '(Türkçe)'
    },
  ].obs;
  void selectLanguage(String language) {
    selectedLanguage.value = language;
    update();
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
