import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDataUtils {
  Widget emptyDataWithoutButton(
      String title, String description, String imagePath) {
    return SizedBox(
      height: 600.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            description,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xFF475467)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Image.asset(
            imagePath,
            width: 317.w,
            height: 237.h,
          ),
        ],
      ),
    );
  }
}
