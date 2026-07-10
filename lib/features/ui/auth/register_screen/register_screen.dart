import 'package:e_commerce_flutter_app/core/utlis/app_assets%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_validators.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/auth_states.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/register_screen/cubit/register_view_model.dart';
import 'package:e_commerce_flutter_app/widget/custom_elevated_button%20.dart';
import 'package:e_commerce_flutter_app/widget/custom_text_form_field%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/dialog_utlis.dart';
class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(text: 'ahmedmostafa@gmail.com');

  TextEditingController passwordController = TextEditingController(text: 'Ahmed@1234');

   TextEditingController confirmPasswordController = TextEditingController(text: 'Ahmed@1234');

   TextEditingController nameController = TextEditingController(text: 'ahmed');

  TextEditingController phoneController = TextEditingController(text: '01001999810');

   RegisterViewModel viewModel = getIt<RegisterViewModel>();


   @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel,AuthStates>(
      bloc: viewModel,
      listener: (context, state) {
        if(state is AuthLoadingStates){
          DialogUtils.showLoading(context: context, message: '...Loading');
        }else if(state is AuthErrorStates){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,title: 'Error', message: state.errorMessage);
        }else if(state is AuthSuccessStates){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'success',title: 'welcome back',posActionName: 'ok',posAction: () {
            Navigator.pushNamed(context, AppRoutes.loginScreen);
          },);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 46.h,top: 91.h,left: 96.w,right: 97.w),
                  child: Image(image: AssetImage(AppAssets.logoECommerce)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Full Name',style: AppTextStyle.normal18White,)
                        ,SizedBox(height: 29.h,),
                        CustomTextFormField(
                          fillColor: AppColors.whiteColor,
                          hintText: 'enter your Full Name',
                          controller: nameController,
                          validator: AppValidators.validateFullName,
                        ),
                        SizedBox(height: 32.h,),
                        Text('Mobile Number',style: AppTextStyle.normal18White,),
                        SizedBox(height: 24.h,),
                        CustomTextFormField(
                          fillColor: AppColors.whiteColor,
                          hintText: 'enter your phone number',
                          controller: phoneController,
                          validator: AppValidators.validatePhoneNumber,
                        ),
                        SizedBox(height: 32.h,),
                        Text('Email',style: AppTextStyle.normal18White,)
                        ,SizedBox(height: 29.h,),
                        CustomTextFormField(
                          fillColor: AppColors.whiteColor,
                          hintText: 'enter your email',
                          controller: emailController,
                          validator: AppValidators.validateEmail,
                        ),
                        SizedBox(height: 32.h,),
                        Text('password',style: AppTextStyle.normal18White,),
                        SizedBox(height: 24.h,),
                        CustomTextFormField(
                          fillColor: AppColors.whiteColor,
                          hintText: 'enter your password',
                          controller: passwordController,
                          validator: AppValidators.validatePassword,
                          suffixIcon: Icon(CupertinoIcons.eye_slash),
                        ),
                        SizedBox(height: 32.h,),
                        Text('confirm password',style: AppTextStyle.normal18White,),
                        SizedBox(height: 24.h,),
                        CustomTextFormField(
                          fillColor: AppColors.whiteColor,
                          hintText: 'enter your password',
                          controller: confirmPasswordController,
                          validator: (val) =>
                              AppValidators.validateConfirmPassword(
                                val,
                                passwordController.text,
                              ),
                          suffixIcon: Icon(CupertinoIcons.eye_slash),
                        ),
                        SizedBox(height: 56.h,),
                        CustomElevatedButton(onPressed: () {
                          //todo: return to home screen
                          viewModel.register(emailController.text, passwordController.text,
                              phoneController.text, nameController.text, confirmPasswordController.text);
                        },
                          text: 'Sign up',
                        ),
                        SizedBox(height: 45.h,),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

