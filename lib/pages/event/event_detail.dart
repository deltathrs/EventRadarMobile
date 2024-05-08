import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:readmore/readmore.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Details',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 308,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'asset/img/event/event_img.png',
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned(
                    left: (MediaQuery.of(context).size.width - 195) / 2,
                    top: (308 - 275) / 2,
                    child: Image.asset(
                      'asset/img/event/event_img.png',
                      width: 195,
                      height: 275,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 316,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    color: Color(0xFFD3E1FF),
                  ),
                  Positioned.fill(
                      child: Center(
                    child: Container(
                      width: 350,
                      height: 270,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CategoryEvent('Seminar'),
                                SizedBox(
                                  width: 5,
                                ),
                                CategoryEvent('Finance'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Online Finances Seminar',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Line(303),
                            SizedBox(
                              height: 10,
                            ),
                            TimeAndCalendar('15 Jan 2021', '09.00 - 11.00 UTC'),
                            SizedBox(
                              height: 2,
                            ),
                            LocationSession('Online'),
                            SizedBox(
                              height: 2,
                            ),
                            Line(303),
                            SizedBox(
                              height: 7,
                            ),
                            OrganizerInfo(
                                'asset/img/event/email_logo.png',
                                'Accounting Finance',
                                'finances.accounting@gmail.com'),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
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
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReadMoreText(
                      'Lorem ipsum dolor sit amet consectetur. Elementum dui dictum fringilla neque. Praesent odio pretium ut in quis condimentum dictum. Eget gravida gravida dui ornare enim faucibus ut dignissim semper. Eget pharetra ullamcorper vel commodo sed elit curabitur lectus lorem. Magnis congue enim nisl imperdiet lorem pulvinar risus. Ut semper ipsum vulputate arcu tristique sit velit ac. Viverra tincidunt adipiscing ut tellus sollicitudin nibh augue viverra.',
                      trimMode: TrimMode.Line,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 11),
                      trimLines: 3,
                      colorClickableText: Color(0xFF1F24EA),
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Show less',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Line(377),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Benefits',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListBenefits('Lorem ipsum dolor.'),
                        SizedBox(
                          height: 2,
                        ),
                        ListBenefits('Lorem ipsum dolor.'),
                        SizedBox(
                          height: 2,
                        ),
                        ListBenefits('Lorem ipsum dolor.'),
                        SizedBox(
                          height: 2,
                        ),
                        ListBenefits('Lorem ipsum dolor.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Line(377),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Eligibility',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListEligibility('Open for public'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Line(377),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Available Ticket',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      EventTicket(Color(0xFF0022BA), 'Free Webinar', 40000, 4,
                          '17 Jan 2021'),
                      SizedBox(
                        height: 10,
                      ),
                      EventTicket(Color(0xFF0022BA), 'Free Webinar', 0, 0,
                          '15 Jan 2021'),
                      SizedBox(
                        height: 10,
                      ),
                      EventTicket(Color(0xFF505050), 'Free Webinar', 50000, 2,
                          '11 Jan 2021'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack EventTicket(
      Color outline, String title, int price, int slot, String date) {
    return Stack(
      children: [
        Container(
          width: 344,
          height: 135,
          decoration: BoxDecoration(
            border: Border.all(color: outline),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Container(
            width: 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: outline,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 20,
          child: Container(
            width: 320,
            height: 125,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF505050)),
                ),
                SizedBox(
                  height: 8,
                ),
                Line(286),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: outline,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Registration Deadline',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F)),
                          ),
                        ],
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            color: Color(0xFF4F4F4F)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: outline,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Tickets Left',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F)),
                          ),
                        ],
                      ),
                      slot == 0
                          ? Text(
                              'Sold out',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                  color: Color(0xFF4F4F4F)),
                            )
                          : Text(
                              '${slot} tickets',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                  color: Color(0xFF4F4F4F)),
                            )
                    ],
                  ),
                ),
                SizedBox(
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
                                fontSize: 11,
                                color: Color(0xFFFFB800)),
                          )
                        : Row(
                            children: [
                              Iconify(
                                '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M7 15h2c0 1.08 1.37 2 3 2s3-.92 3-2c0-1.1-1.04-1.5-3.24-2.03C9.64 12.44 7 11.78 7 9c0-1.79 1.47-3.31 3.5-3.82V3h3v2.18C15.53 5.69 17 7.21 17 9h-2c0-1.08-1.37-2-3-2s-3 .92-3 2c0 1.1 1.04 1.5 3.24 2.03C14.36 11.56 17 12.22 17 15c0 1.79-1.47 3.31-3.5 3.82V21h-3v-2.18C8.47 18.31 7 16.79 7 15"/></svg>',
                                color: Color(0xFFFFB800),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Rp ${price}',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Color(0xFFFFB800)),
                              )
                            ],
                          ),
                    Iconify(
                        '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 50 50"><path fill="#1a34ff" d="M25 42c-9.4 0-17-7.6-17-17S15.6 8 25 8s17 7.6 17 17s-7.6 17-17 17m0-32c-8.3 0-15 6.7-15 15s6.7 15 15 15s15-6.7 15-15s-6.7-15-15-15"/><path fill="#1a34ff" d="M16 24h18v2H16z"/><path fill="#1a34ff" d="M24 16h2v18h-2z"/></svg>'),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row ListEligibility(String eligibility) {
    return Row(
      children: [
        Iconify(
            '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="#14ff3b" d="M12 10a2 2 0 0 0-2 2a2 2 0 0 0 2 2c1.11 0 2-.89 2-2a2 2 0 0 0-2-2"/></svg>'),
        SizedBox(
          width: 5,
        ),
        Text(
          eligibility,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Color(0xFF4F4F4F)),
        )
      ],
    );
  }

  Row ListBenefits(String benefit) {
    return Row(
      children: [
        Iconify(
            '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="#14ff3b" d="M12 10a2 2 0 0 0-2 2a2 2 0 0 0 2 2c1.11 0 2-.89 2-2a2 2 0 0 0-2-2"/></svg>'),
        SizedBox(
          width: 5,
        ),
        Text(
          benefit,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Color(0xFF4F4F4F)),
        )
      ],
    );
  }

  Container Line(double widthLine) {
    return Container(
      height: 1,
      width: widthLine,
      color: Color(0xFFC9C9C9),
    );
  }

  OrganizerInfo(String email_logo, String name, String email) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(email_logo),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4F4F4F)),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              email,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4F4F4F)),
            ),
          ],
        ),
        Spacer(),
        Iconify(
          '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M7.8 2h8.4C19.4 2 22 4.6 22 7.8v8.4a5.8 5.8 0 0 1-5.8 5.8H7.8C4.6 22 2 19.4 2 16.2V7.8A5.8 5.8 0 0 1 7.8 2m-.2 2A3.6 3.6 0 0 0 4 7.6v8.8C4 18.39 5.61 20 7.6 20h8.8a3.6 3.6 0 0 0 3.6-3.6V7.6C20 5.61 18.39 4 16.4 4zm9.65 1.5a1.25 1.25 0 0 1 1.25 1.25A1.25 1.25 0 0 1 17.25 8A1.25 1.25 0 0 1 16 6.75a1.25 1.25 0 0 1 1.25-1.25M12 7a5 5 0 0 1 5 5a5 5 0 0 1-5 5a5 5 0 0 1-5-5a5 5 0 0 1 5-5m0 2a3 3 0 0 0-3 3a3 3 0 0 0 3 3a3 3 0 0 0 3-3a3 3 0 0 0-3-3"/></svg>',
          color: Color(0xFF686868),
        ),
        SizedBox(
          width: 5,
        ),
        Iconify(
          '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M19.05 4.91A9.816 9.816 0 0 0 12.04 2c-5.46 0-9.91 4.45-9.91 9.91c0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21c5.46 0 9.91-4.45 9.91-9.91c0-2.65-1.03-5.14-2.9-7.01m-7.01 15.24c-1.48 0-2.93-.4-4.2-1.15l-.3-.18l-3.12.82l.83-3.04l-.2-.31a8.264 8.264 0 0 1-1.26-4.38c0-4.54 3.7-8.24 8.24-8.24c2.2 0 4.27.86 5.82 2.42a8.183 8.183 0 0 1 2.41 5.83c.02 4.54-3.68 8.23-8.22 8.23m4.52-6.16c-.25-.12-1.47-.72-1.69-.81c-.23-.08-.39-.12-.56.12c-.17.25-.64.81-.78.97c-.14.17-.29.19-.54.06c-.25-.12-1.05-.39-1.99-1.23c-.74-.66-1.23-1.47-1.38-1.72c-.14-.25-.02-.38.11-.51c.11-.11.25-.29.37-.43s.17-.25.25-.41c.08-.17.04-.31-.02-.43s-.56-1.34-.76-1.84c-.2-.48-.41-.42-.56-.43h-.48c-.17 0-.43.06-.66.31c-.22.25-.86.85-.86 2.07c0 1.22.89 2.4 1.01 2.56c.12.17 1.75 2.67 4.23 3.74c.59.26 1.05.41 1.41.52c.59.19 1.13.16 1.56.1c.48-.07 1.47-.6 1.67-1.18c.21-.58.21-1.07.14-1.18s-.22-.16-.47-.28"/></svg>',
          color: Color(0xFF686868),
        ),
      ],
    );
  }

  LocationSession(String location) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xFF0022BA),
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            location,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4F4F4F)),
          ),
        ],
      ),
    );
  }

  TimeAndCalendar(String date, String time) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF0022BA),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                date,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F)),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: Color(0xFF0022BA),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                time,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CategoryEvent(String text) {
    return Container(
      width: 100,
      height: 22,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF888888)),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: Color(0xFF888888)),
        ),
      ),
    );
  }
}
