import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:store_app/features/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/views/register_view.dart';
import 'package:store_app/features/home/presentation/views/home_view.dart';
import 'package:store_app/features/onboarding/views/on_boarding_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/splash/views/splash_view.dart';

class AppRouterName {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String onBoarding = '/onBoarding';
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
          builder: (_) => const RegisterView(),
        );
      case AppRouterName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
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
