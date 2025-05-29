import 'dart:ui';

import 'package:event_radar2/feature/components/utils/url_launcher_utils.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class TicketDetail extends StatefulWidget {
  final TicketDetailModel ticketDetailModel;
  final bool isFinished;
  const TicketDetail(
      {super.key, required this.ticketDetailModel, this.isFinished = false});

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ProfileCubit>()
        .getEoData(widget.ticketDetailModel.organizerId);
  }

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat("d MMMM yyyy", "id").format(dateTime);
  }

  String formatTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat.Hm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Details',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is EoDataLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 308.h,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            "$baseUrlImage${widget.ticketDetailModel.eventThumbnail}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'asset/img/event/placeholder.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.grey.withOpacity(0.1),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Positioned(
                            left: (MediaQuery.of(context).size.width - 195.w) /
                                2.w,
                            top: (308.h - 275.h) / 2.h,
                            child: Image.network(
                              "$baseUrlImage${widget.ticketDetailModel.eventThumbnail}",
                              width: 195.w,
                              height: 275.h,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  width: 195.w,
                                  height: 275.h,
                                  'asset/img/event/placeholder.jpg',
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 316.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            color: const Color(0xFFD3E1FF),
                          ),
                          Positioned.fill(
                              child: Center(
                            child: Container(
                              width: 350.w,
                              height: 300.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        ...widget.ticketDetailModel.categories
                                            .map((category) => Row(
                                                  children: [
                                                    CategoryEvent(category),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      widget.ticketDetailModel.name,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      color: Color(0xFFC9C9C9),
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TimeAndCalendar(
                                        widget.ticketDetailModel.datetime,
                                        widget.ticketDetailModel.endDatetime),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    LocationSession(widget
                                            .ticketDetailModel.isOnline
                                        ? 'Online'
                                        : widget.ticketDetailModel.location),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Divider(
                                      color: Color(0xFFC9C9C9),
                                      thickness: 1,
                                    ),
                                    OrganizerInfo(
                                        "$baseUrlImage${state.eoModel.profile}",
                                        widget.ticketDetailModel.organizerName,
                                        state.eoModel.email,
                                        state.eoModel.phoneNumber),
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MarkdownViewer(
                              widget.ticketDetailModel.eventDetail,
                              styleSheet: MarkdownStyle(
                                paragraph: GoogleFonts.poppins(fontSize: 13.sp),
                                headline1: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                                headline2: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                                headline3: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                                strongEmphasis: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600),
                                emphasis: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontStyle: FontStyle.italic),
                                listItem: GoogleFonts.poppins(fontSize: 13.sp),
                                blockquote: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontStyle: FontStyle.italic),
                                codeSpan: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    backgroundColor: Colors.grey[200]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          widget.isFinished
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Attendance Ticket',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 400.h,
                                      child: ListView.builder(
                                          itemCount: widget
                                              .ticketDetailModel.tickets.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10.h),
                                              child: eventTicket(
                                                  widget
                                                              .ticketDetailModel
                                                              .tickets[index]
                                                              .ticketType ==
                                                          "Standard Ticket"
                                                      ? const Color(0xFF505050)
                                                      : const Color(0xFF0022BA),
                                                  widget
                                                      .ticketDetailModel
                                                      .tickets[index]
                                                      .ticketType,
                                                  widget.ticketDetailModel
                                                      .tickets[index].price,
                                                  widget
                                                      .ticketDetailModel
                                                      .tickets[index]
                                                      .ticketLimit,
                                                  formatDate(widget
                                                      .ticketDetailModel
                                                      .tickets[index]
                                                      .registrationEnd
                                                      .toIso8601String()),
                                                  widget.ticketDetailModel
                                                      .tickets[index].id),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget eventTicket(Color outline, String title, double price, int slot,
      String date, String ticketId) {
    return Stack(
      children: [
        Container(
          width: 344.w,
          height: 145.h,
          decoration: BoxDecoration(
            border: Border.all(color: outline),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Container(
            width: 11.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
              color: outline,
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          left: 15.w,
          child: Container(
            width: 310.w,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF505050)),
                ),
                const Divider(
                  color: Color(0xFFC9C9C9),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: 224.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: outline,
                            ),
                            Text(
                              ' Registration Deadline',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4F4F4F)),
                            ),
                          ],
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 8.sp,
                              color: const Color(0xFF4F4F4F)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: 224.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: outline,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Tickets Left',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4F4F4F)),
                            ),
                          ],
                        ),
                        slot == 0
                            ? Text(
                                'Sold out',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8.sp,
                                    color: const Color(0xFF4F4F4F)),
                              )
                            : Text(
                                '$slot tickets',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8.sp,
                                    color: const Color(0xFF4F4F4F)),
                              )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    price <= 0
                        ? Text(
                            'FREE',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                                color: const Color(0xFFFFB800)),
                          )
                        : Row(
                            children: [
                              const Iconify(
                                '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M7 15h2c0 1.08 1.37 2 3 2s3-.92 3-2c0-1.1-1.04-1.5-3.24-2.03C9.64 12.44 7 11.78 7 9c0-1.79 1.47-3.31 3.5-3.82V3h3v2.18C15.53 5.69 17 7.21 17 9h-2c0-1.08-1.37-2-3-2s-3 .92-3 2c0 1.1 1.04 1.5 3.24 2.03C14.36 11.56 17 12.22 17 15c0 1.79-1.47 3.31-3.5 3.82V21h-3v-2.18C8.47 18.31 7 16.79 7 15"/></svg>',
                                color: Color(0xFFFFB800),
                              ),
                              Text(
                                ' Rp $price',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: const Color(0xFFFFB800)),
                              )
                            ],
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row listEligibility(String eligibility) {
    return Row(
      children: [
        const Iconify(
            '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="#14ff3b" d="M12 10a2 2 0 0 0-2 2a2 2 0 0 0 2 2c1.11 0 2-.89 2-2a2 2 0 0 0-2-2"/></svg>'),
        const SizedBox(
          width: 5,
        ),
        Text(
          eligibility,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: const Color(0xFF4F4F4F)),
        )
      ],
    );
  }

  Row listBenefits(String benefit) {
    return Row(
      children: [
        const Iconify(
            '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="#14ff3b" d="M12 10a2 2 0 0 0-2 2a2 2 0 0 0 2 2c1.11 0 2-.89 2-2a2 2 0 0 0-2-2"/></svg>'),
        const SizedBox(
          width: 5,
        ),
        Text(
          benefit,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: const Color(0xFF4F4F4F)),
        )
      ],
    );
  }

  OrganizerInfo(String emailLogo, String name, String email, String phone) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.network(emailLogo),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4F4F4F)),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              email,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4F4F4F)),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            UrlLauncherUtils.launchURL(actionType: 'whatsapp', value: phone);
          },
          child: Image.asset(
            'asset/img/event_organizer/whatsapp.png',
            width: 30.w,
            height: 30.h,
          ),
        )
      ],
    );
  }

  LocationSession(String location) {
    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: Color(0xFF0022BA),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            location,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4F4F4F)),
          ),
        ],
      ),
    );
  }

  TimeAndCalendar(DateTime startDate, DateTime endDate) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF0022BA),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                formatDate(startDate.toIso8601String()),
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4F4F4F)),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.watch_later_outlined,
                color: Color(0xFF0022BA),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                "${formatTime(startDate.toIso8601String())} - ${formatTime(endDate.toIso8601String())}",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4F4F4F)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CategoryEvent(String text) {
    return Container(
      width: 100.w,
      height: 22.h,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF888888)),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 9.sp,
              color: const Color(0xFF888888)),
        ),
      ),
    );
  }
}
