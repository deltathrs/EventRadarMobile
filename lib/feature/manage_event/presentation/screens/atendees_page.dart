import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/atendees/atendees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AtendeesPage extends StatefulWidget {
  final String eventId;
  const AtendeesPage({Key? key, required this.eventId}) : super(key: key);

  @override
  _AtendeesPageState createState() => _AtendeesPageState();
}

class _AtendeesPageState extends State<AtendeesPage> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AtendeesCubit>().getAtendeesList(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Attendees List',
          style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      body: BlocBuilder<AtendeesCubit, AtendeesState>(
        builder: (context, state) {
          if (state is AtendeesLoaded) {
            if (state.atendees.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.atendees.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  state.atendees[index].profile != null
                                      ? "$baseUrlImage${state.atendees[index].profile}"
                                      : (state.atendees[index].profileGoogle ??
                                          ""),
                                ),
                                onBackgroundImageError: (_, __) {
                                  AssetImage(
                                      'assets/img/common/placeholder_avatar.jpeg');
                                },
                                radius: 30.r,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.atendees[index].fullname,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    state.atendees[index].ticketType,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: EmptyDataUtils().emptyDataWithoutButton(
                    'No Participants Yet',
                    'There are currently no attendees for this event.',
                    'asset/img/event/empty_cart.png'),
              );
            }
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
