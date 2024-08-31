import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyText1 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyText2 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyTextSmall = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );
}
