import 'package:e_commerce_flutter_app/config/di.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_assets%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_validators.dart';
import 'package:e_commerce_flutter_app/core/utlis/dialog_utlis.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/auth_states.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/login_screen/cubit/login_view_model.dart';
import 'package:e_commerce_flutter_app/widget/custom_elevated_button%20.dart';
import 'package:e_commerce_flutter_app/widget/custom_text_form_field%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: 'ahmedmostafa@gmail.com');

   TextEditingController passwordController = TextEditingController(text: 'ahmedmostafa11');

   bool isConfirmPasswordVisible =true;

   LoginViewModel viewModel = getIt<LoginViewModel>();

   @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel,AuthStates>(
      bloc: viewModel,
      listener: (context, state) {
        if(state is AuthLoadingStates){
          DialogUtils.showLoading(context: context, message: '...Loading');
        }else if(state is AuthErrorStates){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,title: 'Error', message: state.errorMessage);
        }else if(state is AuthSuccessStates){
           DialogUtils.hideLoading(context);
           DialogUtils.showMessage(context: context, message: 'success',title: 'welcome back');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 88.h,top: 91.h,left: 96.w,right: 97.w),
                  child: Image(image: AssetImage(AppAssets.eCommerce)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Welcome Back To Route',style: AppTextStyle.title24White,),
                        SizedBox(height: 8.h,),
                        Text('Please sign in with your mail',style: AppTextStyle.label16White,)
                        ,SizedBox(height: 40.h,),
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
                          suffixIcon: IconButton(onPressed: () {
                           setState(() {
                             isConfirmPasswordVisible = !isConfirmPasswordVisible;
                           });
                          },
                              icon: Icon(
                            isConfirmPasswordVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,)),
                          obscureText: !isConfirmPasswordVisible,
                        ),
                        SizedBox(height: 16.h,),
                        Text('forget password',style: AppTextStyle.normal18White,textAlign: TextAlign.end,),
                        SizedBox(height: 56.h,),
                        CustomElevatedButton(onPressed: () {
                          //todo: login
                          viewModel.login(emailController.text, passwordController.text);

                        },
                          text: 'Login',
                        ),
                        SizedBox(height: 32.h,),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(onPressed: () {
                                      // todo : create account
                                      Navigator.pushNamed(context, AppRoutes.registerScreen);
                                    }, child:Text(
                                      'Don’t have an account?create account',
                                      style: AppTextStyle.normal16WhitePoppins,
                                      textAlign: TextAlign.start,
                                    ),
                                    ),
                                  ),
                                ],
                              ),
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
    super.dispose();
  }
}
