import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/core/helper/app_assets.dart';

import '../../../core/locale/app_translations.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: kDiscoverAmazingProducts.tr(),
    description: kExploreWideRangeQuality.tr(),
    image: AppAssets.onboarding1Image,
  ),
  OnboardingModel(
    title: kSeamlessShoppingExperience.tr(),
    description: kEnjoyFastSecureShopping.tr(),
    image: AppAssets.onboarding2Image,
  ),
  OnboardingModel(
    title: kExclusiveDealsAndRewards.tr(),
    description: kGetSpecialDiscounts.tr(),
    image: AppAssets.onboarding3Image,
  ),
];
