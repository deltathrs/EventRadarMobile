import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetUtils {
  static void showCustomBottomSheet(BuildContext context,
      {required Widget child}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen height control
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: child,
          ),
        );
      },
    );
  }

  static Future<void> displayResultBottomSheet({
    required String title,
    required String description,
    required String image,
    required String completion,
    required BuildContext context,
    Function()? onTap,
    bool isDismiss = true, // Default value
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: isDismiss,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 277.h,
                  color: const Color(0xFFF1F0F0),
                  child: Center(
                    child: Image.asset(
                      image,
                      width: 237.w,
                      height: 223.h,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 175.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                          width: 283.w,
                          child: Text(
                            description,
                            style: TextStyle(
                                fontFamily: 'Citroen',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: 388.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              color: const Color(0xFF1F24EA)),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Center(
                                child: Text(
                              completion,
                              style: TextStyle(
                                  fontFamily: 'Citroen',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
