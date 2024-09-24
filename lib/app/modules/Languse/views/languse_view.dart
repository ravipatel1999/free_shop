import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/textStyle.dart';
import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/languse_controller.dart';

class LanguseView extends GetView<LanguseController> {
  const LanguseView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text(
          'Language',
          style: CustomTextStyles.appBarMainText,
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.SIGN_UP);
            },
            child: Container(
              height: height * 0.03,
              width: width * 0.1,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
        child: GetBuilder<LanguseController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    final language = controller.languages[index];
                    bool isSelected = controller.selectedLanguage.value ==
                        language['language'];

                    return GestureDetector(
                      onTap: () {
                        controller.selectLanguage(language['language']!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: isSelected
                                  ? Border.all(
                                      width: 1.5,
                                      color: AppColors.buttonColor,
                                    )
                                  : null),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(language['flag']!),
                              radius: 15,
                            ),
                            title: Text(
                              language['language']!,
                              style: isSelected
                                  ? CustomTextStyles.bodyTextBold
                                  : CustomTextStyles.bodyTextNormal,
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                language['translation']!,
                                style: isSelected
                                    ? CustomTextStyles.bodyTextBold
                                    : CustomTextStyles.bodyTextNormal,
                              ),
                            ),
                            selected: isSelected,
                            selectedTileColor:
                                isSelected ? Colors.blue[100] : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
