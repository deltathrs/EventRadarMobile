import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleEventPage extends StatefulWidget {
  const ScheduleEventPage({super.key});

  @override
  State<ScheduleEventPage> createState() => _ScheduleEventPageState();
}

class _ScheduleEventPageState extends State<ScheduleEventPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  // Map<DateTime, List<Storedatacalender>> eventday = {};

  // void storeDataCalender(List<Speaker> speakerList) {
  //   eventday.clear();
  //   for (var speaker in speakerList) {
  //     if (speaker.seminarList.isNotEmpty) {
  //       for (var e in speaker.seminarList ?? []) {
  //         DateTime date = DateTime(e.date.year, e.date.month, e.date.day);
  //         eventday[date] = eventday[date] ?? [];
  //         eventday[date]!.add(Storedatacalender(
  //             seminarDate: e.date,
  //             seminarTitle: e.title,
  //             seminarDesc: e.desc,
  //             seminarModa: e.moda,
  //             seminarTime: e.time));
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    // Speakerservice().getData().then(
    //   (value) {
    //     setState(() {
    //       storeDataCalender(value);
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Schedule", style: TextStyle()),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TableCalendar(
                      calendarStyle: CalendarStyle(
                        defaultTextStyle:
                            TextStyle(fontWeight: FontWeight.bold),
                      ),
                      focusedDay: _focusedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2030),
                      eventLoader: (day) {
                        final eventdate =
                            DateTime(day.year, day.month, day.day);
                        return eventday[eventdate]
                                ?.map(
                                  (e) => e.seminarTitle,
                                )
                                .toList() ??
                            [];
                      },
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }),
                ),
                Text(
                  "Events",
                  style: Appstyle.styletext1.copyWith(fontSize: 20),
                ),
                eventday.containsKey(DateTime(_selectedDay.year,
                        _selectedDay.month, _selectedDay.day))
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: eventday[DateTime(_selectedDay.year,
                                _selectedDay.month, _selectedDay.day)]!
                            .length,
                        itemBuilder: (context, index) {
                          final datas = eventday[DateTime(_selectedDay.year,
                              _selectedDay.month, _selectedDay.day)]![index];
                          return Eventcard(
                              seminarTime: datas.seminarTime,
                              seminarTitle: datas.seminarTitle,
                              seminarDesc: datas.seminarDesc,
                              seminarModa: datas.seminarModa);
                        },
                      )
                    : Center(
                        child: Text("No Events on this date"),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
