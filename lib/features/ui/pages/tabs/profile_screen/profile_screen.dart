import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../widget/custom_elevated_button .dart';
import '../../../../../widget/custom_text_form_field .dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // TODO: Replace these with real data coming from your auth/user
  // repository, provider, cubit, or bloc instead of hardcoded strings.
  static const String _userFullName = 'Mohamed Mohamed Nabil';
  static const String _userEmail = 'mohamed.N@gmail.com';
  static const String _userPassword = '••••••••••••••••••••••';
  static const String _userPhone = '01122118855';
  static const String _userAddress = '6th October, street 11.....';

  late final Map<String, TextEditingController> _controllers;

  // Tracks whether each field is currently unlocked for editing.
  final Map<String, bool> _isEditable = {
    'name': false,
    'email': false,
    'password': false,
    'phone': false,
    'address': false,
  };

  bool get _isAnyFieldEditable => _isEditable.values.any((e) => e);

  @override
  void initState() {
    super.initState();
    _controllers = {
      'name': TextEditingController(text: _userFullName),
      'email': TextEditingController(text: _userEmail),
      'password': TextEditingController(text: _userPassword),
      'phone': TextEditingController(text: _userPhone),
      'address': TextEditingController(text: _userAddress),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEdit(String key) {
    setState(() => _isEditable[key] = !(_isEditable[key] ?? false));
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Send `_controllers` values to your update-profile use case
      // (API call / repository method) here.
      FocusScope.of(context).unfocus();
      setState(() {
        _isEditable.updateAll((key, value) => false);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primaryColor,
          content: Text(
            'Profile updated successfully',
            style: AppTextStyle.normal16White,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Account', style: AppTextStyle.bold20Black),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                SizedBox(height: 24.h),
                _buildWelcomeHeader(),
                SizedBox(height: 28.h),
                _buildEditableField(
                  fieldKey: 'name',
                  label: 'Your full name',
                  keyboardType: TextInputType.name,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter your full name'
                      : null,
                ),
                _buildEditableField(
                  fieldKey: 'email',
                  label: 'Your E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    return emailRegex.hasMatch(value)
                        ? null
                        : 'Please enter a valid email';
                  },
                ),
                _buildEditableField(
                  fieldKey: 'password',
                  label: 'Your password',
                  obscureText: true,
                  validator: (value) => (value == null || value.length < 6)
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                _buildEditableField(
                  fieldKey: 'phone',
                  label: 'Your mobile number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter your mobile number'
                      : null,
                ),
                _buildEditableField(
                  fieldKey: 'address',
                  label: 'Your Address',
                  maxLines: 2,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter your address'
                      : null,
                ),
                SizedBox(height: 12.h),
                if (_isAnyFieldEditable) _buildSaveButton(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Text(
      'Route',
      style: AppTextStyle.bold28Blue.copyWith(fontStyle: FontStyle.italic),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, ${_controllers['name']!.text.split(' ').first}',
          style: AppTextStyle.bold24Blue,
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(_controllers['email']!.text, style: AppTextStyle.normal16Grey),
            Spacer(),
            IconButton(
              onPressed: () {
                SharedPreferencesUtils.removeData(key: 'token');
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout, color: AppColors.redColor, size: 24.w),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required String fieldKey,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    final bool isEditable = _isEditable[fieldKey] ?? false;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.normal16Grey),
          SizedBox(height: 8.h),
          IgnorePointer(
            ignoring: !isEditable,
            child: Opacity(
              opacity: isEditable ? 1 : 0.85,
              child: CustomTextFormField(
                controller: _controllers[fieldKey],
                keyboardType: keyboardType,
                obscureText: obscureText,
                maxLines: obscureText ? 1 : maxLines,
                validator: validator,
                borderSideColor: isEditable
                    ? AppColors.primaryColor
                    : AppColors.transparentColor,
                suffixIcon: IconButton(
                  splashRadius: 20.r,
                  onPressed: () => _toggleEdit(fieldKey),
                  icon: Icon(
                    isEditable ? Icons.edit : Icons.edit_outlined,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: _onSave,
        text: 'Save Changes',
        backgroundColor: AppColors.primaryColor,
        textStyle: AppTextStyle.button20Blue.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}