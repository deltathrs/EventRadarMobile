import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomepageEventCard extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String image;
  final DateTime lastRegistrationDate;
  final DateTime eventDate;
  final String eventType;
  final List<String> eventCategory;

  const HomepageEventCard({
    Key? key,
    this.controller,
    required this.title,
    required this.image,
    required this.lastRegistrationDate,
    required this.eventDate,
    required this.eventType,
    required this.eventCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatDate(String isoDate) {
      DateTime dateTime = DateTime.parse(isoDate);
      return DateFormat("d MMMM yyyy", "id_ID").format(dateTime);
    }

    return Card(
      borderOnForeground: true,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
          color: Colors.grey,
          width: 0.5.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          children: [
            eventImage(image),
            SizedBox(
              width: 200.w,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _roundedBackground(eventType, false),
                            const SizedBox(width: 8),
                            Expanded(
                                child: _roundedBackground(
                                    eventCategory.join(', '), true)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        cardTitle(title),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Last Regist',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF888888),
                              ),
                            ),
                            Text(
                              formatDate(
                                  lastRegistrationDate.toIso8601String()),
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Event Date',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF888888),
                              ),
                            ),
                            Text(
                              formatDate(eventDate.toIso8601String()),
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eventImage(String image) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xFF888888)),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Text cardTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _roundedBackground(String text, bool isCategory) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: isCategory ? Border.all(color: Color(0xFF888888)) : null,
        color: isCategory ? null : Color(0xFFDADAFB),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isCategory ? Color(0xFF888888) : Color(0xFF0022BA),
        ),
      ),
    );
  }
}
