import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app/core/api/api.dart';
import 'package:store_app/core/cache/local_cache.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/inputs/login_inputs.dart';
import 'package:store_app/features/auth/data/inputs/register_inputs.dart';
import 'package:store_app/features/auth/data/inputs/reset_password_inputs.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';

class AuthRepo {
  Future<Either<Failure, User>> signIn(LoginInputs loginInputs) async {
    return _authenticate('auth/signin', loginInputs.toJson());
  }

  Future<Either<Failure, User>> signUp(RegisterInputs registerInputs) async {
    return _authenticate('auth/signup', registerInputs.toJson());
  }

  Future<Either<String, String>> forgetPassword(String email) async {
    try {
      final response = await API.post(
        'auth/forgotPasswords',
        data: {"email": email},
      );

      if (response.data['statusMsg'] == 'success') {
        return Right(
          response.data['message'],
        ); // Success case
      } else {
        return Left(
          response.data['message'],
        ); // Failure case
      }
    } catch (e) {
      return const Left(
        "There is no user registered with this email address",
      );
    }
  }

  Future<Either<String, String>> verifyResetCode(String resetCode) async {
    try {
      final response = await API.post(
        'auth/verifyResetCode',
        data: {
          "resetCode": resetCode,
        },
      );

      // Handle success case
      if (response.data['status']?.toLowerCase() == 'success') {
        return const Right(
          "Reset code verified successfully",
        ); // Success response
      }

      return Left(response.data['message'] ?? "An unknown error occurred");
    } catch (e) {
      return const Left("Reset code is invalid or has expired");
    }
  }

  Future<Either<String, String>> resetPassword(
      String email, String newPassword) async {
    try {
      final response = await API.put(
        'auth/resetPassword',
        data: {"email": email, "newPassword": newPassword},
      );

      if (response.data.containsKey('token')) {
        return Right(response.data['token']);
      } else {
        return Left(response.data['message'] ?? 'Unknown error');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response?.data['message'] ?? "Server error");
      } else {
        return const Left("Network error");
      }
    }
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
          message: 'Incorrect email or password',
          statusMsg: 'Fail',
        ),
      );
    }
  }
}
