import 'package:flutter/material.dart';

class EventBox extends StatefulWidget {
  const EventBox({super.key});

  @override
  State<EventBox> createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378,
      height: 121,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF4F4F4F)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('asset/img/search/event_thumbnail.png'),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      categoryEvent('Seminar'),
                      categoryEvent('Business'),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Flexible(
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Color(0xFF231FEA)),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Last Regist',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF888888)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '12 Jan 2021',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        'Event Date',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF888888)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '15 Jan 2021',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF6E6E6E)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image.asset('asset/img/search/favorite_icon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryEvent(String category) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: 55,
        height: 15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFF888888)),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 7,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888)),
          ),
        ),
      ),
    );
  }
}
