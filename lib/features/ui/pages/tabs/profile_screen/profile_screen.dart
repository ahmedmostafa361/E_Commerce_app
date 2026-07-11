import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cache_save_data/auth_local_storage.dart';
import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../widget/custom_elevated_button .dart';
import '../../../../../widget/custom_text_form_field .dart';
import '../../../../../widget/toast_bar_message.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

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

    // Real data, read from what was cached at login/register time.
    final cachedUser = AuthLocalStorage.getUser();
    final cachedAddress = AuthLocalStorage.getAddress();
    // Local-only — never returned by the backend at all, only ever
    // captured directly from what the user typed at registration (if this
    // is the same device they registered on).
    final cachedPhone = AuthLocalStorage.getPhone();

    _controllers = {
      'name': TextEditingController(text: cachedUser?.name ?? ''),
      'email': TextEditingController(text: cachedUser?.email ?? ''),
      // No backend supports fetching/changing a password here — this field
      // starts blank and is only used to *set* a new one (see the TODO in
      // _onSave). Never pre-filled with anything, since there's nothing
      // genuine to show.
      'password': TextEditingController(),
      'phone': TextEditingController(text: cachedPhone ?? ''),
      // Device-local only — no backend field exists for this at all.
      'address': TextEditingController(text: cachedAddress ?? ''),
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

  Future<void> _onSave() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Address and phone are genuinely local-only, so this actually
      // persists both — neither has a backend field to save to.
      await AuthLocalStorage.saveAddress(_controllers['address']!.text.trim());
      await AuthLocalStorage.savePhone(_controllers['phone']!.text.trim());

      // TODO: name/email changes and a new password all need a real
      // update-profile / change-password API — neither exists yet in what
      // you've shared. Once you add those use cases, call them here with
      // _controllers['name']!.text, _controllers['email']!.text, and (only
      // if non-empty) _controllers['password']!.text.

      FocusScope.of(context).unfocus();
      setState(() {
        _isEditable.updateAll((key, value) => false);
      });

      if (mounted) {
        AppToast.success(context, 'Profile updated successfully');
      }
    }
  }

  Future<void> _logout() async {
    await SharedPreferencesUtils.removeData(key: 'token');
    await AuthLocalStorage.clear();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
          (route) => false,
    );
  }

  String get _initials {
    final name = _controllers['name']!.text.trim();
    if (name.isEmpty) return '?';
    final parts = name.split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first.characters.first : '';
    final last = parts.length > 1 ? parts.last.characters.first : '';
    return (first + last).toUpperCase();
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
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(
                Icons.logout_rounded, color: AppColors.redColor, size: 22.sp),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                SizedBox(height: 28.h),
                _buildFieldsCard(),
                SizedBox(height: 20.h),
                if (_isAnyFieldEditable) _buildSaveButton(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final name = _controllers['name']!.text.trim();
    final email = _controllers['email']!.text.trim();
    final displayName = name.isNotEmpty ? name
        .split(' ')
        .first : 'there';

    return Center(
      child: Column(
        children: [
          Container(
            width: 84.w,
            height: 84.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.65)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              _initials,
              style: AppTextStyle.bold28Blue.copyWith(
                  color: AppColors.whiteColor, fontSize: 26.sp),
            ),
          ),
          SizedBox(height: 14.h),
          Text('Welcome, $displayName', style: AppTextStyle.bold24Blue),
          SizedBox(height: 4.h),
          if (email.isNotEmpty)
            Text(
              email,
              style: AppTextStyle.normal16Grey.copyWith(fontSize: 14.sp),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _buildFieldsCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableField(
            fieldKey: 'name',
            label: 'Full name',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            validator: (value) =>
            (value == null || value
                .trim()
                .isEmpty)
                ? 'Please enter your full name'
                : null,
          ),
          _buildDivider(),
          _buildEditableField(
            fieldKey: 'email',
            label: 'Email address',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              return emailRegex.hasMatch(value)
                  ? null
                  : 'Please enter a valid email';
            },
          ),
          _buildDivider(),
          _buildEditableField(
            fieldKey: 'password',
            label: 'New password',
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) return null;
              return value.length < 6
                  ? 'Password must be at least 6 characters'
                  : null;
            },
          ),
          _buildDivider(),
          _buildEditableField(
            fieldKey: 'phone',
            label: 'Mobile number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) =>
            (value == null || value
                .trim()
                .isEmpty) ? 'Please enter your mobile number' : null,
          ),
          _buildDivider(),
          _buildEditableField(
            fieldKey: 'address',
            label: 'Address',
            icon: Icons.location_on_outlined,
            maxLines: 2,
            validator: (value) =>
            (value == null || value
                .trim()
                .isEmpty) ? 'Please enter your address' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Divider(
          height: 1, thickness: 1, color: AppColors.scaffoldBackgroundColor),
    );
  }

  Widget _buildEditableField({
    required String fieldKey,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    final bool isEditable = _isEditable[fieldKey] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 15.sp,
                color: AppColors.primaryColor.withOpacity(0.7)),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyle.normal16Grey.copyWith(
                fontSize: 12.5.sp,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        // Scoped Theme override — CustomTextFormField hard-codes its input
        // style to `Theme.of(context).textTheme.headlineSmall` internally,
        // which is what was rendering huge here. Overriding it locally
        // (only within this screen) shrinks it to a sane, luxurious size
        // without touching the shared widget or any other screen that uses
        // it (e.g. Login/Register).
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(
              headlineSmall: AppTextStyle.normal16Grey.copyWith(
                color: AppColors.blackColor,
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: IgnorePointer(
            ignoring: !isEditable,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isEditable ? 1 : 0.9,
              child: CustomTextFormField(
                controller: _controllers[fieldKey],
                keyboardType: keyboardType,
                obscureText: obscureText,
                maxLines: obscureText ? 1 : maxLines,
                validator: validator,
                fillColor: isEditable
                    ? AppColors.whiteColor
                    : AppColors.scaffoldBackgroundColor,
                borderSideColor:
                isEditable ? AppColors.primaryColor : AppColors
                    .transparentColor,
                hintText: fieldKey == 'password'
                    ? 'Leave blank to keep current'
                    : null,
                suffixIcon: IconButton(
                  splashRadius: 18.r,
                  onPressed: () => _toggleEdit(fieldKey),
                  icon: Icon(
                    isEditable ? Icons.check_circle_rounded : Icons
                        .edit_outlined,
                    color: AppColors.primaryColor,
                    size: 19.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
      ],
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
            color: AppColors.whiteColor, fontSize: 16.sp),
      ),
    );
  }
}