import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/event/event_cubit.dart';
import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleEoPage extends StatefulWidget {
  const ScheduleEoPage({super.key});

  @override
  State<ScheduleEoPage> createState() => _ScheduleEoPageState();
}

class _ScheduleEoPageState extends State<ScheduleEoPage> {
  Map<DateTime, List<MyEventModel>> listEvent = {};
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  late final ValueNotifier<List<MyEventModel>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().getMyEvents();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier(_getEventForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvent.value = _getEventForDay(selectedDay);
      });
    }
  }

  List<MyEventModel> _getEventForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return listEvent[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Schedule',
          style: GoogleFonts.poppins(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() {
          context.read<EventCubit>().getMyEvents();
        }),
        child: BlocBuilder<EventCubit, EventState>(
          builder: (context, state) {
            if (state is MyEventLoaded) {
              listEvent = {};

              for (var event in state.myEvents) {
                final date = DateTime(event.datetime.year,
                    event.datetime.month, event.datetime.day);

                if (listEvent[date] == null) {
                  listEvent[date] = [event];
                } else {
                  listEvent[date]!.add(event);
                }
              }

              _selectedEvent.value = _getEventForDay(_selectedDay!);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF89AFFF)),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: TableCalendar(
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          // calendarFormat:,

                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: _onDaySelected,
                          eventLoader: _getEventForDay,
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue, // Warna lingkaran
                              shape: BoxShape.circle,
                            ),
                            cellMargin: EdgeInsets.all(10.w),
                            selectedTextStyle: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            defaultTextStyle: GoogleFonts.poppins(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                            weekendTextStyle: GoogleFonts.poppins(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                          ),
                          headerStyle: HeaderStyle(
                            titleTextStyle: GoogleFonts.poppins(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                            formatButtonTextStyle: GoogleFonts.poppins(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF909090)),
                            weekendStyle: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF909090)),
                          ),
                          // onFormatChanged: (format){
                          //   if)
                          // },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          firstDay: DateTime.utc(2025),
                          lastDay: DateTime.utc(2030),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Events',
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ValueListenableBuilder<List<MyEventModel>>(
                          valueListenable: _selectedEvent,
                          builder: (context, value, _) {
                            if (value.isNotEmpty) {
                              return ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return eventBox(value[index]);
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Event Empty At this Date',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

String formatTime(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate).toLocal();
  return DateFormat.Hm().format(dateTime);
}

Widget eventBox(MyEventModel event) {
  return Stack(
    children: [
      Container(
        width: 378.w,
        height: 129.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
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
            color: Colors.blue,
          ),
        ),
      ),
      Positioned(
        top: 10.h,
        left: 15.w,
        child: SizedBox(
          width: 300.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "asset/img/event/box.png",
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '${formatTime(event.datetime.toIso8601String())} - ${formatTime(event.endDatetime.toIso8601String())}',
                    style: GoogleFonts.lato(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9A9A9A)),
                  ),
                ],
              ),
              Text(
                event.name,
                style: GoogleFonts.almarai(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 34.h,
                child: Text(
                  event.eventDetail
                      .replaceAll(RegExp(r'\[.*?\]\(.*?\)|[*_#>`~-]'), '')
                      .trim(),
                  style: GoogleFonts.lato(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF585A66),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 18.w,
                    color: Color(0xFF333333),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    event.isOnline ? 'Online' : 'Onsite',
                    style: GoogleFonts.lato(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF585A66)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}
