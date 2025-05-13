import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EventBox extends StatefulWidget {
  final EventModel eventData;
  final bool isFavoritePage;
  const EventBox(
      {super.key, required this.eventData, this.isFavoritePage = false});

  @override
  State<EventBox> createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;
  bool isFavourite = false;

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat("d MMMM yyyy", "id").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                            fit: BoxFit.contain,
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
                        children: [
                          categoryEvent(
                              widget.eventData.isOnline ? 'Online' : 'Onsite',
                              false),
                          SizedBox(
                            width: 5.w,
                          ),
                          categoryEvent(widget.eventData.categories[1], true),
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
        ),
        widget.isFavoritePage
            ? SizedBox.shrink()
            : BlocListener<FavouriteEventCubit, FavouriteEventState>(
                listener: (context, state) {
                  if (state is AddToFavouriteFailed) {
                    setState(() {
                      isFavourite = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                        context
                            .read<FavouriteEventCubit>()
                            .addToFavourite(widget.eventData.id);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF1F1F1),
                            border: Border.all(color: Color(0xFF6E6E6E))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            width: 15.w,
                            height: 18.h,
                            isFavourite
                                ? "asset/img/event/wishlist_done.png"
                                : "asset/img/event/wishlist.png",
                            color:
                                isFavourite ? Colors.blue : Color(0xFF6E6E6E),
                          ),
                        ),
                      )),
                ),
              ),
      ],
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
