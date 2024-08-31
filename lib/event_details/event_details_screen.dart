import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../booking_confirmation_screen/booking_confirmation_screen.dart';
import '../event_data.dart';
import '../event_model.dart';
import '../reusable_components/custom_app_bar.dart';
import '../reusable_components/custom_button.dart';
import '../reusable_components/custom_circle_avatar.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: event.title),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: getCoverPhoto(event.category),
              width: double.infinity,
              height: 300.h,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/img/Placeholder.png', fit: BoxFit.cover, height: 300.h),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 195.h),
                Center(
                  child: Hero(
                    tag: 'event_${event.title}',
                    child: CustomCircleAvatar(
                      imageUrl: event.imageUrl,
                      radius: 120.r,
                    ),
                  ),
                ),
                // SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              style: AppTextStyles.heading2.copyWith(fontSize: 24.sp),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: AppColors.primaryColor),
                                SizedBox(width: 10.w),
                                Text(
                                  event.date,
                                  style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
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
                                  style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
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
                                  style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        'Description:',
                        style: AppTextStyles.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        event.description,
                        style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        text: 'Book Now',
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Confirm Booking', style: AppTextStyles.heading2.copyWith(fontSize: 24.sp)),
                              content: Text('Are you sure you want to confirm this booking?',
                                  style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp)),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancel',
                                      style: AppTextStyles.bodyText2
                                          .copyWith(color: AppColors.textColor, fontSize: 16.sp)),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondaryColor,
                                  ),
                                  child: Text('Confirm',
                                      style: AppTextStyles.bodyText2
                                          .copyWith(color: AppColors.iconColor, fontSize: 16.sp)),
                                ),
                              ],
                            ),
                          );

                          if (confirm) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmationScreen(event: event),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
