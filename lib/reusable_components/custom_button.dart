import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.iconColor, fontSize: 18.sp),
        ),
      ),
    );
  }
}
