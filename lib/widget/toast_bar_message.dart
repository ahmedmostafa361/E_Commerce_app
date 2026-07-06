import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utlis/app_colors .dart';
import '../core/utlis/app_text .dart';

/// Semantic type of the toast — controls the accent color and icon.
enum ToastType { success, error, warning, info }

/// Where the toast appears on screen.
enum ToastPosition { top, bottom }

/// A lightweight, dependency-free toast utility built on [Overlay].
///
/// Works from anywhere you have a [BuildContext] — no [Scaffold] required,
/// so it won't conflict with SnackBars, bottom nav bars, or FABs.
///
/// Usage:
/// ```dart
/// AppToast.success(context, 'Profile updated successfully');
/// AppToast.error(context, 'Something went wrong');
/// AppToast.warning(context, 'Please check your internet connection');
/// AppToast.info(context, 'New update available');
///
/// // Or fully custom:
/// AppToast.show(
///   context,
///   message: 'Custom message',
///   type: ToastType.info,
///   position: ToastPosition.top,
///   duration: const Duration(seconds: 2),
/// );
///
/// // Override colors for a single toast (both are nullable — omit either
/// // one, or both, to keep the defaults):
/// AppToast.success(
///   context,
///   'Item added successfully',
///   backgroundColor: Colors.white,
///   textColor: Colors.black,
/// );
/// ```
class AppToast {
  AppToast._();

  static OverlayEntry? _currentEntry;
  static Timer? _currentTimer;

  /// Shows a toast with full control over its type, position, and duration.
  ///
  /// [backgroundColor] and [textColor] are optional (nullable) — leave them
  /// out to use the default look-and-feel built into the widget. Pass them
  /// only when you want to override the defaults for this specific toast.
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
  }) {
    _dismiss();

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (_) => _ToastWidget(
        message: message,
        type: type,
        position: position,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onDismissed: _dismiss,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);

    _currentTimer = Timer(duration, _dismiss);
  }

  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
  }) {
    show(
      context,
      message: message,
      type: ToastType.error,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
  }) {
    show(
      context,
      message: message,
      type: ToastType.info,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  /// Removes the currently visible toast (if any) immediately.
  static void _dismiss() {
    _currentTimer?.cancel();
    _currentTimer = null;
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _ToastStyle {
  final Color color;
  final IconData icon;

  const _ToastStyle({required this.color, required this.icon});
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final ToastPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onDismissed;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.onDismissed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    final beginOffset = widget.position == ToastPosition.top
        ? const Offset(0, -0.3)
        : const Offset(0, 0.3);

    _slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // NOTE: success/warning use fixed semantic hex colors since these are
  // universal status colors, independent of any app's brand palette.
  // error/info are pulled from AppColors so they stay in sync with your
  // app theme. Swap these for AppColors entries if you'd rather keep every
  // color centralized in one file.
  _ToastStyle get _style {
    switch (widget.type) {
      case ToastType.success:
        return const _ToastStyle(
          color: Color(0xFF2ECC71),
          icon: Icons.check_circle_rounded,
        );
      case ToastType.error:
        return _ToastStyle(
          color: AppColors.redColor,
          icon: Icons.error_rounded,
        );
      case ToastType.warning:
        return const _ToastStyle(
          color: Color(0xFFF5A623),
          icon: Icons.warning_rounded,
        );
      case ToastType.info:
        return _ToastStyle(
          color: AppColors.primaryColor,
          icon: Icons.info_rounded,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final mediaQuery = MediaQuery.of(context);

    // Accent color (icon + left border) always reflects the toast type,
    // so the type is still visually recognizable even with custom colors.
    final accentColor = style.color;
    final bgColor =
        widget.backgroundColor ?? AppColors.blackColor.withValues(alpha: 0.92);
    final txtColor = widget.textColor ?? AppTextStyle.normal16White.color;

    return Positioned(
      left: 16.w,
      right: 16.w,
      top: widget.position == ToastPosition.top
          ? mediaQuery.padding.top + 16.h
          : null,
      bottom: widget.position == ToastPosition.bottom
          ? mediaQuery.padding.bottom + 16.h
          : null,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: GestureDetector(
              onTap: widget.onDismissed,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border(
                    left: BorderSide(color: accentColor, width: 4.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(style.icon, color: accentColor, size: 22.sp),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: AppTextStyle.normal16White.copyWith(
                          color: txtColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
