import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/event/event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/screens/manage_event_page.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/eo_event_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyEventPage extends StatefulWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EventCubit>().getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'My Events',
          style: GoogleFonts.poppins(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is MyEventLoaded) {
            if (state.myEvents.isNotEmpty) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: state.myEvents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(15.w),
                          child: EoEventBox(eventData: state.myEvents[index]),
                        );
                      }));
            } else {
              return Center(
                child: EmptyDataUtils().emptyDataWithoutButton(
                    "Your Event is Empty",
                    "Create a new event to get started",
                    "asset/img/event/empty_data.jpg"),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: IconButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ManageEventPage()));
        },
        icon: Container(
          decoration: BoxDecoration(
              color: Color(0xFF0052FF),
              borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 15.w,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Create Event',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
