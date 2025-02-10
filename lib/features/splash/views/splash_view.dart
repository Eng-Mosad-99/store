import 'package:flutter/material.dart';
import 'package:store_app/core/cache/local_cache.dart';
import 'package:store_app/core/helper/app_assets.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/service/service_locator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isOnboarding =
      serviceLocator<LocalCache>().getData(key: 'onboarding') ?? false;
  final cachedUser =
      serviceLocator<LocalCache>().getData(key: 'isLogin') ?? false;
  @override
  void initState() {
    super.initState();

    navigatePage();
  }

  void navigatePage() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
          context,
          isOnboarding
              ? cachedUser == true
                  ? AppRouterName.home
                  : AppRouterName.login
              : AppRouterName.onBoarding,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
