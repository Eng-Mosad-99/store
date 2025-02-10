import 'package:get_it/get_it.dart';
import 'package:store_app/core/cache/local_cache.dart';
import 'package:store_app/features/auth/data/repo/auth_repo.dart';
import '../../features/auth/presentation/controller/bloc/auth_bloc.dart';
import '../api/api.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // Register Cache
  serviceLocator.registerLazySingleton<LocalCache>(() => LocalCache());

  // Register API
  serviceLocator.registerLazySingleton<API>(() => API());

  //! R E P O S I T O R Y
  // Register AuthRepo
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepo());

//! B L O C
  // Register AuthBloc
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(serviceLocator<AuthRepo>()),
  );
}
