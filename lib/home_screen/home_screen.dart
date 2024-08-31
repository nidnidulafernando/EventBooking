import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../event_data.dart';
import '../event_details/event_details_screen.dart';
import '../event_model.dart';
import '../reusable_components/custom_app_bar.dart';
import '../reusable_components/custom_circle_avatar.dart';
import '../reusable_components/custom_dropdown_form_field.dart';
import '../util/app_colors.dart';
import '../util/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> filteredEvents = [];
  final List<String> categories = ['All', 'Music', 'Tech', 'Sports', 'Art'];
  final List<String> locations = ['All', 'New York', 'San Francisco', 'Los Angeles', 'Chicago', 'Miami', 'Boston'];

  String selectedCategory = 'All';
  String selectedLocation = 'All';
  String selectedDate = 'All';

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredEvents = allEvents;
  }

  void _filterEvents() {
    setState(() {
      filteredEvents = allEvents.where((event) {
        final matchesCategory = selectedCategory == 'All' || event.category == selectedCategory;
        final matchesDate = selectedDate == 'All' || event.date == selectedDate;
        final matchesLocation = selectedLocation == 'All' || event.location == selectedLocation;
        return matchesCategory && matchesDate && matchesLocation;
      }).toList();
    });
  }

  Future<void> _showFilterDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Events', style: AppTextStyles.heading2.copyWith(fontSize: 24.sp)),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0.6.sh,
              minHeight: 0.3.sh,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDropdownFormField(
                    value: selectedCategory,
                    items: categories,
                    labelText: 'Category',
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today, size: 24.sp),
                      labelStyle: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                        setState(() {
                          selectedDate = formattedDate;
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomDropdownFormField(
                    value: selectedLocation,
                    items: locations,
                    labelText: 'Location',
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Filter',
                  style: AppTextStyles.bodyText1.copyWith(color: AppColors.primaryColor, fontSize: 18.sp)),
              onPressed: () {
                _filterEvents();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Reset',
                  style: AppTextStyles.bodyText1.copyWith(color: AppColors.primaryColor, fontSize: 18.sp)),
              onPressed: () {
                setState(() {
                  selectedCategory = 'All';
                  selectedLocation = 'All';
                  selectedDate = 'All';
                  dateController.clear();
                  filteredEvents = allEvents;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',
                  style: AppTextStyles.bodyText1.copyWith(color: AppColors.primaryColor, fontSize: 18.sp)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upcoming Events',
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, size: 30.sp),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(event: filteredEvents[index]),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'event_${filteredEvents[index].title}',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.r,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          color: AppColors.backgroundColor,
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final imageHeight = constraints.maxHeight / 2;
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                                    child: CachedNetworkImage(
                                      imageUrl: getCoverPhoto(filteredEvents[index].category),
                                      width: double.infinity,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Image.asset('assets/img/Placeholder.png',
                                          fit: BoxFit.cover, height: imageHeight),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Spacer(),
                                    CustomCircleAvatar(imageUrl: filteredEvents[index].imageUrl,radius: 55.r),
                                    SizedBox(height: 8.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            filteredEvents[index].title,
                                            style: AppTextStyles.bodyText2.copyWith(fontSize: 16.sp),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            filteredEvents[index].date,
                                            style: AppTextStyles.bodyTextSmall.copyWith(fontSize: 14.sp),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            filteredEvents[index].location,
                                            style: AppTextStyles.bodyTextSmall.copyWith(fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
