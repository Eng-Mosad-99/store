import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/constants/constants.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/helper/my_validator.dart';
import 'package:store_app/core/widgets/custom_button.dart';
import 'package:store_app/core/widgets/custom_text_form_field.dart';
import 'package:store_app/core/widgets/my_loading_widget.dart';
import 'package:store_app/features/auth/data/inputs/reset_password_inputs.dart';
import 'package:store_app/features/auth/presentation/controller/bloc/auth_bloc.dart';
import '../../../../core/helper/app_colors.dart';
import 'login_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool _isPasswordVisible = true;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.size.height * 0.08,
                  ),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email Address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: AppConstants.kFontFamily,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) => MyValidators.emailValidator(value),
                    hntText: 'Enter your email',
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: AppConstants.kFontFamily,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    validator: (value) => MyValidators.passwordValidator(value),
                    controller: passwordController,
                    hntText: 'Enter your password',
                    obscureText: _isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isPasswordVisible
                            ? Colors.grey
                            : AppColors.blackColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.size.height * 0.1,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is ResetPasswordSuccess) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRouterName.login,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Password reset successful!",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const MyLoadingWidget();
                      }

                      return CustomButton(
                        buttonText: "Reset Password",
                        onPressed: () {
                          final email = emailController.text.trim();
                          final newPassword = passwordController.text.trim();

                          context.read<AuthBloc>().add(
                                ResetPasswordEvent(
                                    email: email, newPassword: newPassword),
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
