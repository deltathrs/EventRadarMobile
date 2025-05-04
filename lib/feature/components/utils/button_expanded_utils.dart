import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildButtonExpanded(
  String title, {
  Function()? onPressed,
  bool? border,
  bool? onLoading = false,
  Widget? prefixIcon,
  bool? enabled,
  Color? color,
  Color? fontColor,
  Color? loadingColor,
  double circularRadius = 10,
}) {
  return ElevatedButton(
    onPressed: enabled == null
        ? onPressed
        : enabled == true
            ? onPressed
            : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? Color.fromARGB(255, 21, 112, 239),
      side: border != null ? BorderSide(color: fontColor ?? Colors.white) : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularRadius),
      ),
      minimumSize: Size(double.infinity, 50), // Full width and 45 height
    ),
    child: Center(
      child: onLoading == false
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) prefixIcon,
                if (prefixIcon != null) SizedBox(width: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: fontColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : SpinKitThreeBounce(
              color: loadingColor ?? Colors.white,
              size: 20.0,
            ),
    ),
  );
}
