import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String value;
  final List<String> items;
  final String labelText;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: AppTextStyles.bodyText1.copyWith(fontSize: 15.sp, color: AppColors.textColor)),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTextStyles.bodyText2.copyWith(fontSize: 15.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      ),
      style: AppTextStyles.bodyText1.copyWith(fontSize: 18.sp),
    );
  }
}
