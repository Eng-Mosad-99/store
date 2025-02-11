import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_colors.dart';
import 'package:store_app/core/helper/app_router.dart';
import 'package:store_app/core/widgets/custom_button.dart';
import 'package:store_app/core/widgets/my_loading_widget.dart';
import 'package:store_app/features/auth/presentation/controller/bloc/auth_bloc.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyCodeSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRouterName.resetPassword,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is VerifyCodeError) {
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
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.size.height * 0.08,
                    ),
                    Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.size.height * 0.1,
                    ),
                    OtpTextField(
                      onSubmit: (value) => setState(() {
                        codeController.text = value;
                      }),
                      onCodeChanged: (value) {
                        setState(() {
                          codeController.text = value;
                        });
                      },
                      numberOfFields: 6,
                      borderColor: const Color(0xFF512DA8),
                      showFieldAsBox: true,
                      filled: true,
                      fillColor: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      fieldWidth: 50.w,
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: size.size.height * 0.1,
                    ),
                    state is VerifyCodeLoading
                        ? const MyLoadingWidget()
                        : CustomButton(
                            buttonText: 'Send',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(
                                  VerifyResetCodeEvent(
                                    resetCode: codeController.text,
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
