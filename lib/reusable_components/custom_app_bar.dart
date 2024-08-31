import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.iconColor,
      ),
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(color: AppColors.iconColor, fontSize: 22.sp),
      ),
      backgroundColor: AppColors.primaryColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(59.h);
}
