import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/widgets/ticket_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishedPage extends StatefulWidget {
  const FinishedPage({Key? key}) : super(key: key);

  @override
  _FinishedPageState createState() => _FinishedPageState();
}

class _FinishedPageState extends State<FinishedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().getTicketList(status: 'completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Finished Events',
          style: GoogleFonts.poppins(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is TicketListLoaded) {
            if (state.tickets.isNotEmpty) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: state.tickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(15.w),
                          child: TicketBox(
                            isFinished: true,
                            eventData: state.tickets[index],
                          ),
                        );
                      }));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: EmptyDataUtils().emptyDataWithoutButton(
                      "Your Registered Event is Empty",
                      "You haven't registered for any events yet.",
                      "asset/img/event/empty_data.jpg"),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
