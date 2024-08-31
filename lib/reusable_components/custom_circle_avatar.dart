import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;
  double? radius;

  CustomCircleAvatar({super.key, required this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 50.r,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      backgroundColor: Colors.grey.shade300,
      onBackgroundImageError: (error, stackTrace) {
        // Handle error
      },
      child: Image.asset('assets/img/Placeholder.png'),
    );
  }
}
