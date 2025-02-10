import 'package:dartz/dartz.dart';
import 'package:store_app/core/api/api.dart';
import 'package:store_app/core/cache/local_cache.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/inputs/login_inputs.dart';
import 'package:store_app/features/auth/data/inputs/register_inputs.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';

class AuthRepo {
  Future<Either<Failure, User>> signIn(LoginInputs loginInputs) async {
    return _authenticate('auth/signin', loginInputs.toJson());
  }

  Future<Either<Failure, User>> signUp(RegisterInputs registerInputs) async {
    return _authenticate('auth/signup', registerInputs.toJson());
  }

  Future<Either<Failure, User>> _authenticate(String url, dynamic data) async {
    try {
      final response = await API.post(
        url,
        data: data,
      );

      AuthResponse authResponse = AuthResponse.fromJson(response.data);
      if (authResponse.message == 'success') {
        var authData = authResponse.user;
        serviceLocator<LocalCache>().saveData(
          key: 'user',
          value: authResponse.toJson(),
        );
        serviceLocator<LocalCache>().saveData(key: 'isLogin', value: true);
        return Right(authData!);
      } else {
        return Left(
          ServerFailure(
            message: authResponse.message!,
            statusMsg: 'Fail!, please try again',
          ),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Error To Login , please try again',
          statusMsg: 'Erroror To Login , please try again',
        ),
      );
    }
  }
}
