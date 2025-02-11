import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';

import '../../../../core/cache/local_cache.dart';
import '../../../../core/helper/app_assets.dart';
import 'widgets/custom_ads_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthResponse? user;
  @override
  void initState() {
    super.initState();
    getUserData();
    _startImageSwitching();
  }

  Future<void> getUserData() async {
    final cachedUser = await serviceLocator<LocalCache>().getData(key: 'user');
    setState(() {
      user = AuthResponse.fromJson(cachedUser);
    });
  }

  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    AppAssets.carouselSlider1,
    AppAssets.carouselSlider2,
    AppAssets.carouselSlider3,
  ];

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: CustomAdsWidget(
              adsImages: adsImages,
              currentIndex: _currentIndex,
              timer: _timer,
            ),
          ),
        ],
      ),
    );
  }
}
