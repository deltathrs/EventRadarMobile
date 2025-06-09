import 'dart:ui';

import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/components/utils/url_launcher_utils.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/home/presentation/cubits/creator_list/creator_list_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_transaction/event_transaction_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/home/presentation/screen/eo_detail_screen.dart';
import 'package:event_radar2/feature/home/presentation/screen/payment_screen.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/handle_content_event/handle_content_event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/screens/manage_event_page.dart';
import 'package:event_radar2/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icons8.dart';
import 'package:intl/intl.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class EventDetail extends StatefulWidget {
  final String eventId;
  final bool isEo;
  String? status;
  EventDetail(
      {super.key, required this.eventId, this.isEo = false, this.status = ""});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;
  final EventDetailCubit eventDetail = GetIt.instance<EventDetailCubit>();
  EventDetailModel? eventDetailModel;
  bool isFavourite = false;
  final EventTransactionCubit eventTransaction =
      GetIt.instance<EventTransactionCubit>();

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
    return BlocConsumer<ManageEventCubit, ManageEventState>(
      listener: (context, state) {
        if (state is SaveEventLoading) {
          BottomSheetUtils.showLoadingDialog(context);
        }
        if (state is SaveEventSuccess) {
          BottomSheetUtils.displayResultBottomSheet(
              title: 'Successfully Change Event Status',
              description: 'Your event status has been successfully changed',
              image: 'asset/img/event/success.jpg',
              completion: 'Back to My Events',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationPage()),
                  (Route<dynamic> route) => false,
                );
              },
              context: context);
        }

        if (state is SaveEventError) {
          Navigator.pop(context);
          BottomSheetUtils.displayResultBottomSheet(
              title: 'Failed to Change Event Status',
              description: state.error,
              image: 'asset/img/event/failed.jpg',
              completion: 'Back',
              onTap: () {
                Navigator.pop(context);
              },
              context: context);
        }
      },
      builder: (context, state) {
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
          body: BlocListener<FavouriteEventCubit, FavouriteEventState>(
            listener: (context, state) {
              if (state is AddToFavouriteFailed) {
                setState(() {
                  isFavourite = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.error.contains("-")
                          ? state.error.split("-").last.trim()
                          : state.error)),
                );
              }
            },
            child: BlocConsumer<EventDetailCubit, EventDetailState>(
              bloc: eventDetail,
              listener: (context, state) {
                if (state is EventDetailLoaded) {
                  isFavourite = state.eventDetail.isLiked ?? false;
                }
              },
              builder: (context, state) {
                if (state is EventDetailLoaded) {
                  eventDetailModel = state.eventDetail;
                  return Scaffold(
                    bottomNavigationBar: widget.isEo &&
                            widget.status != 'completed'
                        ? Container(
                            height: 90.h,
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: IconButton(
                                onPressed: () {
                                  if (widget.status == 'draft' ||
                                      widget.status == 'rejected') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                      create: (context) =>
                                                          HandleContentEventCubit(),
                                                    ),
                                                    BlocProvider(
                                                      create: (context) =>
                                                          GetIt.instance<
                                                              ManageEventCubit>(),
                                                    ),
                                                  ],
                                                  child: ManageEventPage(
                                                    isCreateNew: false,
                                                    eventDetail:
                                                        eventDetailModel,
                                                    id: eventDetailModel?.id
                                                        .toString(),
                                                  ),
                                                )));
                                  } else if (widget.status == 'approved' ||
                                      widget.status == 'ongoing') {
                                    BottomSheetUtils.displayChoiceBottomSheet(
                                        title: widget.status == 'approved'
                                            ? 'Start Event'
                                            : 'End Event',
                                        description:
                                            'Are you sure you want to ${widget.status == "approved" ? "change status to ongoing" : widget.status == "ongoing" ? "change status to completed" : "change the status"}?',
                                        image: 'asset/img/event/success.jpg',
                                        buttonFont1: 'Cancel',
                                        onTap1: () {
                                          Navigator.pop(context);
                                        },
                                        buttonFont2: 'Change Status',
                                        onTap2: () {
                                          context
                                              .read<ManageEventCubit>()
                                              .changeEventStatus(
                                                  widget.status == "approved"
                                                      ? "ongoing"
                                                      : widget.status ==
                                                              "ongoing"
                                                          ? "completed"
                                                          : "",
                                                  eventDetailModel!.id);
                                        },
                                        context: context);
                                  } else {
                                    BottomSheetUtils.displayResultBottomSheet(
                                        title: 'Cannot Edit Event',
                                        description:
                                            'Please await further notice from us before proceeding with the management of your event',
                                        image: 'asset/img/event/success.jpg',
                                        completion: 'Okay',
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        context: context);
                                  }
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: widget.status == 'draft' ||
                                            widget.status == 'approved' ||
                                            widget.status == 'rejected' ||
                                            widget.status == 'ongoing'
                                        ? Color(0xFF231EAF)
                                        : Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 15.w),
                                    child: Center(
                                        child: (widget.status == "approved" ||
                                                widget.status == "ongoing")
                                            ? Text(
                                                'Change Event Status',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                'Edit Event',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                    body: SingleChildScrollView(
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
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: (MediaQuery.of(context).size.width -
                                          195.w) /
                                      2.w,
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
                            width: double.infinity,
                            height: 356.h,
                            child: Stack(
                              children: [
                                Container(
                                  color: const Color(0xFFD3E1FF),
                                ),
                                Positioned.fill(
                                    child: Center(
                                  child: Container(
                                    width: 350.w,
                                    // height: 300.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 5,
                                            runSpacing: 5,
                                            children: state
                                                .eventDetail.categories
                                                .map<Widget>((category) =>
                                                    CategoryEvent(category))
                                                .toList(),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.eventDetail.name,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp),
                                              ),
                                              widget.isEo
                                                  ? SizedBox.shrink()
                                                  : IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isFavourite =
                                                              !isFavourite;
                                                        });
                                                        context
                                                            .read<
                                                                FavouriteEventCubit>()
                                                            .addToFavourite(
                                                                state
                                                                    .eventDetail
                                                                    .id);
                                                      },
                                                      icon: Container(
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xFFF1F1F1),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFF6E6E6E))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                            width: 15.w,
                                                            height: 18.h,
                                                            isFavourite
                                                                ? "asset/img/event/wishlist_done.png"
                                                                : "asset/img/event/wishlist.png",
                                                            color: isFavourite
                                                                ? Color(
                                                                    0xFF231FEA)
                                                                : Color(
                                                                    0xFF6E6E6E),
                                                          ),
                                                        ),
                                                      )),
                                            ],
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
                                              state.eventDetail.datetime,
                                              state.eventDetail.endDatetime),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          LocationSession(
                                              state.eventDetail.isOnline
                                                  ? 'Online'
                                                  : state.eventDetail.location),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          const Divider(
                                            color: Color(0xFFC9C9C9),
                                            thickness: 1,
                                          ),
                                          OrganizerInfo(state.eventOrganizer),
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
                                      paragraph:
                                          GoogleFonts.poppins(fontSize: 13.sp),
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
                                      listItem:
                                          GoogleFonts.poppins(fontSize: 13.sp),
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
                                state.eventDetail.tickets.isEmpty
                                    ? EmptyDataUtils().emptyDataWithoutButton(
                                        'Ticket is Empty',
                                        "You haven't make any ticket for this event yet",
                                        'asset/img/event/empty_data.jpg')
                                    : Text(
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
                                ListView.builder(
                                    itemCount: state.eventDetail.tickets.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                            state.eventDetail.tickets[index]
                                                .price,
                                            state.eventDetail.tickets[index]
                                                .ticketLimit,
                                            formatDate(state.eventDetail
                                                .tickets[index].registrationEnd
                                                .toIso8601String()),
                                            state
                                                .eventDetail.tickets[index].id),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
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
          ),
        );
      },
    );
  }

  Widget eventTicket(Color outline, String title, double price, int slot,
      String date, String ticketId) {
    final formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
            .format(price);

    return BlocListener<EventTransactionCubit, EventTransactionState>(
      bloc: eventTransaction,
      listener: (context, state) async {
        if (state is EventTransactionLoading) {
          ticketId = state.ticketId;
          BottomSheetUtils.showLoadingDialog(context);
        }

        if (state is EventTransactionLoaded) {
          Navigator.pop(context);
          if (state.message.contains('already have this ticket')) {
            BottomSheetUtils.displayResultBottomSheet(
                title: "Failed to Buy Event",
                description: state.message,
                image: "asset/img/event/failed.jpg",
                completion: "Back",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                    (route) => false,
                  );
                },
                context: context);
          } else if (state.message.contains('purchased successfully')) {
            BottomSheetUtils.displayResultBottomSheet(
                title: "Successfully Buy Event",
                description: state.message,
                image: "asset/img/event/success.jpg",
                completion: "Back To Event List",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                    (route) => false,
                  );
                },
                context: context);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                          cubit: eventTransaction,
                          url: state.message,
                          ticketId: ticketId,
                        )));
          }
          // BottomSheetUtils.displayResultBottomSheet(
          //     title: "Successfully Buy Event",
          //     description: "Event has been added to your collection list",
          //     image: "asset/img/event/success.jpg",
          //     completion: "Continue",
          //     onTap: () {
          //       Navigator.pop(context);
          //       Navigator.pop(context);
          //       Navigator.pop(context);
          //     },
          //     context: context);
        }
        if (state is EventTransactionFailed) {
          if (mounted) {
            Navigator.pop(context);

            BottomSheetUtils.displayResultBottomSheet(
              title: "Failed to Buy Event",
              description: state.error.contains("-")
                  ? state.error.split("-").last.trim()
                  : state.error,
              image: "asset/img/event/failed.jpg",
              completion: "Back",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationPage()),
                  (route) => false,
                );
              },
              context: context,
            );
          }
        }
      },
      child: Stack(
        children: [
          Container(
            width: 344.w,
            height: 170.h,
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
                                  formattedPrice,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                      color: const Color(0xFFFFB800)),
                                )
                              ],
                            ),
                      !widget.isEo && slot > 0
                          ? IconButton(
                              onPressed: () {
                                BottomSheetUtils.displayChoiceBottomSheet(
                                    title: 'Buy Ticket?',
                                    description:
                                        'Are you sure you want to buy this ticket?',
                                    image: 'asset/img/event/success.jpg',
                                    buttonFont1: 'Cancel',
                                    onTap1: () {
                                      Navigator.pop(context);
                                    },
                                    buttonFont2: 'Buy',
                                    onTap2: () {
                                      Navigator.pop(context);
                                      eventTransaction.buyEvent(ticketId);
                                    },
                                    context: context);
                              },
                              icon: const Iconify(
                                  '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 50 50"><path fill="#1a34ff" d="M25 42c-9.4 0-17-7.6-17-17S15.6 8 25 8s17 7.6 17 17s-7.6 17-17 17m0-32c-8.3 0-15 6.7-15 15s6.7 15 15 15s15-6.7 15-15s-6.7-15-15-15"/><path fill="#1a34ff" d="M16 24h18v2H16z"/><path fill="#1a34ff" d="M24 16h2v18h-2z"/></svg>'),
                            )
                          : const SizedBox.shrink(),
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

  OrganizerInfo(ListEoModel eo) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  GetIt.instance<CreatorListCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  GetIt.instance<FavouriteEventCubit>(),
                            ),
                          ],
                          child: EoDetailScreen(
                              eoModel: eo,
                              eoImage: "$baseUrlImage${eo.profile}"),
                        )));
          },
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Center(
                child: Image.network("$baseUrlImage${eo.profile}"),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eo.fullname,
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
              eo.email,
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
            UrlLauncherUtils.launchURL(
                actionType: 'whatsapp', value: eo.phoneNumber);
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
