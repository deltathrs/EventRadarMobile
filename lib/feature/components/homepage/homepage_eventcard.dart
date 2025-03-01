import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageEventCard extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final Image image;
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
    return Card(
      borderOnForeground: true,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side:  BorderSide(
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
              height: 165.h,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _roundedBackground(eventType)),
                            const SizedBox(width: 8),
                            Expanded(
                                child: _roundedBackground(
                                    eventCategory.join(', '))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        cardTitle(title),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                             Icon(
                              Icons.calendar_today,
                              size: 16.w,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Last Regist: ${lastRegistrationDate.day}/${lastRegistrationDate.month}/${lastRegistrationDate.year}',
                              style:  TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16.w,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Event Date: ${eventDate.day}/${eventDate.month}/${eventDate.year}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
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

  SizedBox eventImage(Image image) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: image,
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

  Widget _roundedBackground(String text) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
