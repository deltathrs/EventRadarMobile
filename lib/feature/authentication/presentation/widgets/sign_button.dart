import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Colors.green, // Default color is green
  }) : super(key: key);

  final Function()? onTap;
  final String text;
  final Color color; // Color parameter for the button

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: color, // Set background color
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
