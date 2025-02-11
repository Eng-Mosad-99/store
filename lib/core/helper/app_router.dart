import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:store_app/features/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:store_app/features/auth/presentation/views/register_view.dart';
import 'package:store_app/features/auth/presentation/views/verify_code_view.dart';
import 'package:store_app/features/cart/presentation/views/cart_view.dart';
import 'package:store_app/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:store_app/features/home/presentation/views/home_view.dart';
import 'package:store_app/features/onboarding/views/on_boarding_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/splash/views/splash_view.dart';

class AppRouterName {
  static const String home = '/home';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String register = '/register';
  static const String onBoarding = '/onBoarding';
  static const String forgetPassword = '/forgetPassword';
  static const String verifyCode = '/verifyCode';
  static const String resetPassword = '/resetPassword';
  static const String dashboard = '/dashboard';
  static const String splash = '/';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    log(settings.name.toString());
    switch (settings.name) {
      case AppRouterName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case AppRouterName.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
        );
      case AppRouterName.login:
        return MaterialPageRoute(
          builder: (_) => initAuthBloc(child: const LoginView()),
        );
      case AppRouterName.register:
        return MaterialPageRoute(
          builder: (_) => initAuthBloc(child: const RegisterView()),
        );
      case AppRouterName.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => initAuthBloc(
              child: initAuthBloc(child: const ForgetPasswordView())),
        );
      case AppRouterName.verifyCode:
        return MaterialPageRoute(
          builder: (_) =>
              initAuthBloc(child: initAuthBloc(child: const VerifyCodeView())),
        );
      case AppRouterName.resetPassword:
        return MaterialPageRoute(
          builder: (_) => initAuthBloc(
              child: initAuthBloc(child: const ResetPasswordView())),
        );
      case AppRouterName.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
        );
      case AppRouterName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case AppRouterName.cart:
        return MaterialPageRoute(
          builder: (_) => const CartView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
