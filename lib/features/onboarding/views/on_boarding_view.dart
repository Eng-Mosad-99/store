import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'package:store_app/core/locale/app_translations.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/onboarding/model/onboarding_model.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper/app_assets.dart';
import '../../../core/helper/app_router.dart';
import '../../../core/widgets/change_lang_dialog.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late bool isEn = context.locale.languageCode == 'en';

  Future<void> _changeLanguage(String langCode) async {
    context.setLocale(Locale(langCode));
    setState(() => isEn = !isEn);
  }

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  void _nextPage() {
    if (_currentIndex < onboardingList.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      serviceLocator<LocalCache>().saveData(key: 'onboarding', value: true);
      Navigator.pushReplacementNamed(
        context,
        AppRouterName.login,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => showLanguageDialog(
                  context,
                  selectedLanguage: isEn ? 'en' : 'ar',
                  onChanged: (value) {
                    setState(() {
                      _changeLanguage(value!);
                      Navigator.of(context).pop();
                    });
                  },
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.langImage,
                      width: 30.w,
                      height: 30.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      isEn ? 'en' : 'عربي',
                      style: TextStyle(
                        fontSize: 20.sp,
                        decoration: TextDecoration.underline,
                        fontFamily: AppConstants.kFontFamily,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: onboardingList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          onboardingList[index].image,
                        ),
                        Text(
                          onboardingList[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          onboardingList[index].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 6.0.h,
                  spacing: 8.0.sp,
                  dotWidth: 6.0.w,
                  dotColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentIndex == 0
                      ? const SizedBox()
                      : CustomButton(
                          text: kBack.tr(),
                          backgroundColor: AppColors.primaryColor,
                          fontSize: 18.sp,
                          onPressed: _previousPage,
                          textColor: Colors.white,
                        ),
                  CustomButton(
                    text: _currentIndex == onboardingList.length - 1
                        ? kGetStarted.tr()
                        : kNext.tr(),
                    backgroundColor: AppColors.primaryColor,
                    fontSize: 18.sp,
                    onPressed: _nextPage,
                    textColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
  });
  final void Function()? onPressed;
  final String text;
  final Color? textColor, backgroundColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? 18.sp,
        ),
      ),
    );
  }
}
