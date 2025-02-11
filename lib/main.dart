import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_app/core/constants/constants.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/helper/bloc_observer.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:easy_logger/easy_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await GetStorage.init();

  setupServiceLocator();

  EasyLocalization.logger.enableLevels = <LevelMessages>[
    LevelMessages.warning,
  ];
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: AppConstants.kPathToTranslation,
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouterName.splash,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}

//! TODO_Signleton_Bloc 
// SingleChildWidget initLanguageBloc({Widget? child}) {
//   return GlobalBlocProvider(
//     create: () => getIt<LanguageBloc>(),
//     child: child,
//   );
// }