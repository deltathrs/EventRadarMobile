import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Map<DateTime, List<TicketDetailModel>> listTicket = {};
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  late final ValueNotifier<List<TicketDetailModel>> _selectedTicket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().getTicketList();
    _selectedDay = _focusedDay;
    _selectedTicket = ValueNotifier(_getTicketForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedTicket.value = _getTicketForDay(selectedDay);
      });
    }
  }

  List<TicketDetailModel> _getTicketForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return listTicket[normalizedDay] ?? [];
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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is TicketListLoaded) {
            listTicket = {};

            for (var ticket in state.tickets) {
              final date = DateTime(ticket.datetime.year, ticket.datetime.month,
                  ticket.datetime.day);

              if (listTicket[date] == null) {
                listTicket[date] = [ticket];
              } else {
                listTicket[date]!.add(ticket);
              }
            }

            _selectedTicket.value = _getTicketForDay(_selectedDay!);
            return Padding(
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
                      eventLoader: _getTicketForDay,
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
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
                  Expanded(
                    child: ValueListenableBuilder<List<TicketDetailModel>>(
                      valueListenable: _selectedTicket,
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
            );
          }
          return Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget eventBox(TicketDetailModel event) {
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
                    '1:00 PM - 2:30 PM',
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
                  event.eventDetail,
                  style: GoogleFonts.lato(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF585A66)),
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
