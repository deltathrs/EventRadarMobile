import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventBox extends StatefulWidget {
  const EventBox({super.key});

  @override
  State<EventBox> createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378.w,
      height: 121.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4F4F4F)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('asset/img/search/event_thumbnail.png'),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      categoryEvent('Seminar'),
                      categoryEvent('Business'),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Flexible(
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: const Color(0xFF231FEA)),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Last Regist',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF888888)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '12 Jan 2021',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        'Event Date',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF888888)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '15 Jan 2021',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 26.w,
              height: 26.h,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6E6E6E)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Image.asset('asset/img/search/favorite_icon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryEvent(String category) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: 55.w,
        height: 15.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF888888)),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 7.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF888888)),
          ),
        ),
      ),
    );
  }
}
