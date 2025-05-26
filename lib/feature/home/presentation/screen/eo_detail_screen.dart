import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/home/presentation/cubits/creator_list/creator_list_cubit.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_box_eo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EoDetailScreen extends StatefulWidget {
  final ListEoModel eoModel;
  final String eoImage;
  const EoDetailScreen({Key? key, required this.eoModel, required this.eoImage})
      : super(key: key);

  @override
  _EoDetailScreenState createState() => _EoDetailScreenState();
}

class _EoDetailScreenState extends State<EoDetailScreen> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CreatorListCubit>().getEvents(widget.eoModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Organizer Details',
          style: GoogleFonts.poppins(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              eoDetailBox(),
              SizedBox(
                height: 10,
              ),
              eoEvents(),
            ],
          ),
        ),
      ),
    );
  }

  Widget eoEvents() {
    return BlocBuilder<CreatorListCubit, CreatorListState>(
      builder: (context, state) {
        if (state is EoEventLoaded) {
          if (state.events.isEmpty) {
            return EmptyDataUtils().emptyDataWithoutButton(
                'No Data Found',
                'This Event Organizer currently does not have any available events',
                "asset/img/event/empty_data.jpg");
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 3 / 5,
            ),

            itemCount: state.events.length,
            itemBuilder: (context, index) {
              return EventBoxEo(event: state.events[index]);
            },
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // opsional, jika dalam Column
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Widget EventBoxEo(EoEventLoaded state, int index, BuildContext context) {
  //   bool isFavourite = state.events[index].isLiked ?? false;
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(22.r),
  //       border: Border.all(
  //         color: Colors.grey.shade300,
  //         width: 1.0,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 5,
  //           offset: const Offset(0, 4),
  //           spreadRadius: 2,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(22.r),
  //             ),
  //             child: Stack(
  //               children: [
  //                 Image.network(
  //                   "$baseUrlImage${state.events[index].eventThumbnail}",
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                   fit: BoxFit.cover,
  //                 ),
  //                 BlocListener<FavouriteEventCubit, FavouriteEventState>(
  //                   listener: (context, state) {
  //                     if (state is AddToFavouriteFailed) {
  //                       setState(() {
  //                         isFavourite = false;
  //                       });
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(content: Text(state.error)),
  //                       );
  //                     }
  //                   },
  //                   child: Align(
  //                     alignment: Alignment.topRight,
  //                     child: IconButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             isFavourite = !isFavourite;
  //                           });
  //                           context
  //                               .read<FavouriteEventCubit>()
  //                               .addToFavourite(state.events[index].id);
  //                         },
  //                         icon: Container(
  //                           decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Color(0xFFF1F1F1),
  //                               border: Border.all(color: Color(0xFF6E6E6E))),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Image.asset(
  //                               width: 15.w,
  //                               height: 18.h,
  //                               isFavourite
  //                                   ? "asset/img/event/wishlist_done.png"
  //                                   : "asset/img/event/wishlist.png",
  //                               color: isFavourite
  //                                   ? Color(0xFF231FEA)
  //                                   : Color(0xFF6E6E6E),
  //                             ),
  //                           ),
  //                         )),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Padding(
  //             padding: EdgeInsets.all(8.w),
  //             child: Column(
  //               // mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   state.events[index].name,
  //                   style: GoogleFonts.inter(
  //                       fontSize: 11.sp,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(0xFF505050)),
  //                 ),
  //                 Text(
  //                   formatDate(state.events[index].datetime.toIso8601String()),
  //                   style: GoogleFonts.inter(
  //                       fontSize: 10.sp,
  //                       fontWeight: FontWeight.w400,
  //                       color: Color(0xFF505050)),
  //                 ),
  //                 Text(
  //                   formatTime(state.events[index].datetime.toIso8601String()),
  //                   style: GoogleFonts.inter(
  //                       fontSize: 10.sp,
  //                       fontWeight: FontWeight.w400,
  //                       color: Color(0xFF505050)),
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => BlocProvider(
  //                                   create: (context) =>
  //                                       GetIt.instance<EventDetailCubit>(),
  //                                   child: EventDetail(
  //                                       eventId: state.events[index].id),
  //                                 )));
  //                   },
  //                   child: Container(
  //                     width: 116.w,
  //                     decoration: BoxDecoration(
  //                         color: Color(0xFF231FEA),
  //                         borderRadius: BorderRadius.circular(15.r)),
  //                     child: Padding(
  //                       padding: EdgeInsets.all(4.w),
  //                       child: Center(
  //                         child: Text(
  //                           'Checkout',
  //                           style: GoogleFonts.inter(
  //                               fontSize: 10.sp,
  //                               fontWeight: FontWeight.w600,
  //                               color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container eoDetailBox() {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // shadow color
            blurRadius: 5, // soften the shadow
            offset: Offset(0, 4), // move down (x, y)
            spreadRadius: 2, // extend the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.eoImage),
                  radius: 32.r,
                ),
                Image.asset(
                  'asset/img/event_organizer/whatsapp.png',
                  width: 30.w,
                  height: 30.h,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.eoModel.fullname,
              style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),

            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //  style: GoogleFonts.inter(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black),
            // )    //   widget.eoModel.email,
            //
          ],
        ),
      ),
    );
  }
}
