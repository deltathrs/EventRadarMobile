import 'dart:ui';

import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:readmore/readmore.dart';

class EventDetail extends StatefulWidget {
  final String eventId;
  const EventDetail({super.key, required this.eventId});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;
  final EventDetailCubit eventDetail = GetIt.instance<EventDetailCubit>();
  final EventDetailCubit eventTransaction = GetIt.instance<EventDetailCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventDetail.getEventDetail(widget.eventId);
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
      body: BlocConsumer<EventDetailCubit, EventDetailState>(
        bloc: eventDetail,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EventDetailLoaded) {
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
                          "$baseUrlImage${state.eventDetail.eventThumbnail}",
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
                          left:
                              (MediaQuery.of(context).size.width - 195.w) / 2.w,
                          top: (308.h - 275.h) / 2.h,
                          child: Image.network(
                            "$baseUrlImage${state.eventDetail.eventThumbnail}",
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
                                      ...state.eventDetail.categories
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
                                    state.eventDetail.name,
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
                                  TimeAndCalendar(state.eventDetail.datetime,
                                      state.eventDetail.endDatetime),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  LocationSession(state.eventDetail.isOnline
                                      ? 'Online'
                                      : state.eventDetail.location),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Divider(
                                    color: Color(0xFFC9C9C9),
                                    thickness: 1,
                                  ),
                                  OrganizerInfo(
                                      'asset/img/event/email_logo.png',
                                      state.eventDetail.organizerName,
                                      'finances.accounting@gmail.com'),
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
                            state.eventDetail.eventDetail,
                            styleSheet: MarkdownStyle(
                              paragraph: GoogleFonts.poppins(fontSize: 13.sp),
                              headline1: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                              headline2: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                              headline3: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                              strongEmphasis: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontWeight: FontWeight.w600),
                              emphasis: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontStyle: FontStyle.italic),
                              listItem: GoogleFonts.poppins(fontSize: 13.sp),
                              blockquote: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontStyle: FontStyle.italic),
                              codeSpan: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  backgroundColor: Colors.grey[200]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Available Ticket',
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
                              itemCount: state.eventDetail.tickets.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: eventTicket(
                                      state.eventDetail.tickets[index]
                                                  .ticketType ==
                                              "Standard Ticket"
                                          ? const Color(0xFF505050)
                                          : const Color(0xFF0022BA),
                                      state.eventDetail.tickets[index]
                                          .ticketType,
                                      state.eventDetail.tickets[index].price,
                                      state.eventDetail.tickets[index]
                                          .ticketLimit,
                                      formatDate(state.eventDetail
                                          .tickets[index].registrationEnd
                                          .toIso8601String()),
                                      state.eventDetail.tickets[index].id),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF0022BA),
            ),
          );
        },
      ),
    );
  }

  Widget eventTicket(Color outline, String title, double price, int slot,
      String date, String ticketId) {
    return BlocListener<EventDetailCubit, EventDetailState>(
      bloc: eventTransaction,
      listener: (context, state) {
        if (state is EventDetailBuyLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }

        if (state is EventDetailBuySuccess) {
          Navigator.pop(context);
          BottomSheetUtils.displayResultBottomSheet(
              title: "Successfully Buy Event",
              description: "Event has been added to your collection list",
              image: "asset/img/event/success.jpg",
              completion: "Continue",
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              context: context);
        }
        if (state is EventDetailBuyFailed) {
          Navigator.pop(context);
          BottomSheetUtils.displayResultBottomSheet(
              title: "Failed to Buy Event",
              description: state.message,
              image: "asset/img/event/failed.jpg",
              completion: "Back",
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              context: context);
        }
      },
      child: Stack(
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
                      slot > 0
                          ? GestureDetector(
                              onTap: () {
                                eventTransaction.buyEvent(ticketId);
                              },
                              child: const Iconify(
                                  '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 50 50"><path fill="#1a34ff" d="M25 42c-9.4 0-17-7.6-17-17S15.6 8 25 8s17 7.6 17 17s-7.6 17-17 17m0-32c-8.3 0-15 6.7-15 15s6.7 15 15 15s15-6.7 15-15s-6.7-15-15-15"/><path fill="#1a34ff" d="M16 24h18v2H16z"/><path fill="#1a34ff" d="M24 16h2v18h-2z"/></svg>'),
                            )
                          : SizedBox.shrink(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  OrganizerInfo(String emailLogo, String name, String email) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(emailLogo),
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
        const Iconify(
          '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M19.05 4.91A9.816 9.816 0 0 0 12.04 2c-5.46 0-9.91 4.45-9.91 9.91c0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21c5.46 0 9.91-4.45 9.91-9.91c0-2.65-1.03-5.14-2.9-7.01m-7.01 15.24c-1.48 0-2.93-.4-4.2-1.15l-.3-.18l-3.12.82l.83-3.04l-.2-.31a8.264 8.264 0 0 1-1.26-4.38c0-4.54 3.7-8.24 8.24-8.24c2.2 0 4.27.86 5.82 2.42a8.183 8.183 0 0 1 2.41 5.83c.02 4.54-3.68 8.23-8.22 8.23m4.52-6.16c-.25-.12-1.47-.72-1.69-.81c-.23-.08-.39-.12-.56.12c-.17.25-.64.81-.78.97c-.14.17-.29.19-.54.06c-.25-.12-1.05-.39-1.99-1.23c-.74-.66-1.23-1.47-1.38-1.72c-.14-.25-.02-.38.11-.51c.11-.11.25-.29.37-.43s.17-.25.25-.41c.08-.17.04-.31-.02-.43s-.56-1.34-.76-1.84c-.2-.48-.41-.42-.56-.43h-.48c-.17 0-.43.06-.66.31c-.22.25-.86.85-.86 2.07c0 1.22.89 2.4 1.01 2.56c.12.17 1.75 2.67 4.23 3.74c.59.26 1.05.41 1.41.52c.59.19 1.13.16 1.56.1c.48-.07 1.47-.6 1.67-1.18c.21-.58.21-1.07.14-1.18s-.22-.16-.47-.28"/></svg>',
          color: Color(0xFF686868),
        ),
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
              fontSize: 10.sp,
              color: const Color(0xFF888888)),
        ),
      ),
    );
  }
}
