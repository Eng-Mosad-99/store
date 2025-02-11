import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/constants/constants.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/helper/my_validator.dart';
import 'package:store_app/core/widgets/custom_button.dart';
import 'package:store_app/features/auth/presentation/controller/bloc/auth_bloc.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRouterName.verifyCode,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        AuthBloc authBloc = context.read<AuthBloc>();
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Forget Password',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.size.height * 0.1,
                    ),
                    Text(
                      'Enter the email address associated with your account , Click to have a password reset link e-mailed to you',
                      style: TextStyle(
                        height: 2.h,
                        fontFamily: AppConstants.kFontFamily,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
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
                      height: size.size.height * 0.1,
                    ),
                    state is ForgetPasswordLoading
                        ? Center(
                            child: SizedBox(
                              width: 10.w,
                              height: 10.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.sp,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : CustomButton(
                            buttonText: 'Send',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(
                                  ForgetPasswordEvent(
                                    email: emailController.text,
                                  ),
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
