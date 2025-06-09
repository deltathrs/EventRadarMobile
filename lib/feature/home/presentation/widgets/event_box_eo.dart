import 'package:event_radar2/feature/home/data/eo_event_model.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_detail.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventBoxEo extends StatefulWidget {
  final EoEventModel event;

  const EventBoxEo({super.key, required this.event});

  @override
  State<EventBoxEo> createState() => _EventBoxEoState();
}

class _EventBoxEoState extends State<EventBoxEo> {
  late bool isFavourite;
  final String baseUrlImage = dotenv.env['BASE_URL']!;

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat("d MMMM yyyy", "id").format(dateTime);
  }

  String formatTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat.Hm().format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    isFavourite = widget.event.isLiked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(22.r),
              ),
              child: Stack(
                children: [
                  Image.network(
                    "$baseUrlImage${widget.event.eventThumbnail}",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  BlocListener<FavouriteEventCubit, FavouriteEventState>(
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
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                            context
                                .read<FavouriteEventCubit>()
                                .addToFavourite(widget.event.id);
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF6E6E6E))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                width: 15.w,
                                height: 18.h,
                                isFavourite
                                    ? "asset/img/event/wishlist_done.png"
                                    : "asset/img/event/wishlist.png",
                                color: isFavourite
                                    ? Color(0xFF231FEA)
                                    : Color(0xFF6E6E6E),
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050)),
                  ),
                  Text(
                    formatDate(widget.event.datetime.toIso8601String()),
                    style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050)),
                  ),
                  Text(
                    formatTime(widget.event.datetime.toIso8601String()),
                    style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050)),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            GetIt.instance<EventDetailCubit>(),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            GetIt.instance<ManageEventCubit>(),
                                      ),
                                      BlocProvider(
                                        create: (context) => GetIt.instance<
                                            FavouriteEventCubit>(),
                                      ),
                                    ],
                                    child:
                                        EventDetail(eventId: widget.event.id),
                                  )));
                    },
                    child: Container(
                      width: 116.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF231FEA),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Center(
                          child: Text(
                            'Check Event',
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
