import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rise_tech_event_booking/booking_confirmation_screen/preview_reciept.dart';
import '../event_model.dart';
import '../reusable_components/custom_app_bar.dart';
import '../reusable_components/custom_button.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';
import '../util/functions.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Event event;

  const BookingConfirmationScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Booking Confirmation'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.secondaryColor,
                  size: 120.r,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  'Thank you for booking!',
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 28.sp,
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.r,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: AppTextStyles.heading2.copyWith(fontSize: 25.sp),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppColors.primaryColor),
                        SizedBox(width: 10.w),
                        Text(
                          event.date,
                          style: AppTextStyles.bodyText1.copyWith(fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.primaryColor),
                        SizedBox(width: 10.w),
                        Text(
                          event.location,
                          style: AppTextStyles.bodyText1.copyWith(fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: AppColors.primaryColor),
                        SizedBox(width: 10.w),
                        Text(
                          '\$${event.price.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyText1.copyWith(fontSize: 18.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                text: 'Preview Receipt',
                onPressed: () async {
                  final file = await generatePdf(event);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewPage(pdfPath: file.path),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: 'Share Receipt',
                onPressed: () => sharePdf(context, event),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: 'Return to Home',
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
