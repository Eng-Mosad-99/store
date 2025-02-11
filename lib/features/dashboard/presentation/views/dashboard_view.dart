import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/core/helper/app_assets.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';
import '../../../../core/cache/local_cache.dart';
import '../../../categories/presentation/views/categories_view.dart';
import '../../../favourite/presentation/views/favourite_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../profile/presentation/views/profile_view.dart';
import 'widgets/home_screen_app_bar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  AuthResponse? user;
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const CategoriesView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final cachedUser = await serviceLocator<LocalCache>().getData(key: 'user');
    setState(() {
      user = AuthResponse.fromJson(cachedUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: const HomeScreenAppBar(),
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          height: 80.h,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Center(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              backgroundColor: AppColors.primaryColor,
              onTap: (value) => setState(() => currentIndex = value),
              items: [
                _bottomNavBarItem(
                    context, AppAssets.homeImage, currentIndex, 0, ''),
                _bottomNavBarItem(
                    context, AppAssets.categoryImage, currentIndex, 1, ''),
                _bottomNavBarItem(
                    context, AppAssets.heartImage, currentIndex, 2, ''),
                _bottomNavBarItem(
                    context, AppAssets.userImage, currentIndex, 3, ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(
    BuildContext context,
    String icon,
    int selectedindex,
    int index,
    String label,
  ) =>
      BottomNavigationBarItem(
        backgroundColor: AppColors.primaryColor,
        icon: Container(
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: selectedindex == index ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: SvgPicture.asset(
            icon,
            height: 25.h,
            colorFilter: ColorFilter.mode(
              selectedindex == index ? AppColors.primaryColor : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        label: label,
      );
}
