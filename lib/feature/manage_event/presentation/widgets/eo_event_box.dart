import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EoEventBox extends StatefulWidget {
  final MyEventModel eventData;
  const EoEventBox({super.key, required this.eventData});

  @override
  State<EoEventBox> createState() => _EoEventBoxState();
}

class _EoEventBoxState extends State<EoEventBox> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat("d MMMM yyyy", "id").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378.w,
      height: 141.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4F4F4F)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: Image.network(
                    "$baseUrlImage${widget.eventData.eventThumbnail}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'asset/img/event/placeholder.jpg',
                        fit: BoxFit.fill,
                      );
                    },
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          categoryEvent(widget.eventData.categories[0], false),
                          if (widget.eventData.categories.length > 1) ...[
                            SizedBox(width: 5.w),
                            categoryEvent(widget.eventData.categories[1], true),
                          ],
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: widget.eventData.status == 'draft'
                                ? Colors.blueGrey
                                : widget.eventData.status == 'waiting'
                                    ? Colors.blue
                                    : widget.eventData.status == 'approved'
                                        ? Colors.green
                                        : widget.eventData.status == 'ongoing'
                                            ? Colors.yellow
                                            : widget.eventData.status ==
                                                    'completed'
                                                ? Colors.green[900]
                                                : widget.eventData.status ==
                                                        'rejected'
                                                    ? Colors.red
                                                    : Color(0xFF231EAF),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Center(
                            child: Text(
                              '${widget.eventData.status[0].toUpperCase()}${widget.eventData.status.substring(1)}',
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Flexible(
                    child: Text(
                      widget.eventData.name,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Event Date',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF888888)),
                      ),
                      Text(
                        DateFormat('d MMMM yyyy', 'id_ID')
                            .format(widget.eventData.datetime),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryEvent(String category, bool isCategory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: isCategory ? Border.all(color: const Color(0xFF888888)) : null,
        color: isCategory ? null : Color(0xFFDADAFB),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
                color: isCategory
                    ? const Color(0xFF888888)
                    : const Color(0xFF0022BA)),
          ),
        ),
      ),
    );
  }
}
