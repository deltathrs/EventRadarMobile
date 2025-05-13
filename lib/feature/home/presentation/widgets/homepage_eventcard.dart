import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomepageEventCard extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String image;
  final DateTime eventDate;
  final String eventType;
  final List<String> eventCategory;

  const HomepageEventCard({
    Key? key,
    this.controller,
    required this.title,
    required this.image,
    required this.eventDate,
    required this.eventType,
    required this.eventCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatDate(String isoDate) {
      DateTime dateTime = DateTime.parse(isoDate);
      initializeDateFormatting('id', null);
      return DateFormat("d MMMM yyyy", "id").format(dateTime);
    }

    return Container(
      width: 175.w,
      height: 226.h,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF888888)),
          borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            eventImage(image),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                categoryLocationBox(eventType, false),
                categoryLocationBox(eventCategory[0], true),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 120.w,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF231FEA)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Date',
                  style: GoogleFonts.poppins(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF888888)),
                ),
                Text(
                  formatDate(eventDate.toIso8601String()),
                  style: GoogleFonts.poppins(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4F4F4F)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget eventImage(String image) {
    return Container(
      width: 89.w,
      height: 115.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'asset/img/event/placeholder.jpg',
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }

  Widget categoryLocationBox(String text, bool isCategory) {
    return Container(
      constraints: BoxConstraints(maxWidth: 95.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: isCategory ? Border.all(color: Color(0xFF888888)) : null,
        color: isCategory ? null : Color(0xFFDADAFB),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: isCategory ? Color(0xFF888888) : Color(0xFF0022BA),
        ),
      ),
    );
  }
}
