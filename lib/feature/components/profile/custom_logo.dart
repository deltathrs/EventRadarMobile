import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLogoWidget extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomLogoWidget({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.w,
      height: 109.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFF4F4F4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 36.w, // Adjust image width as needed
            height: 36.h, // Adjust image height as needed
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4E4E55),
            ),
          ),
        ],
      ),
    );
  }
}
