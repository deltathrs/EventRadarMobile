import 'package:flutter/material.dart';

class CustomInfoWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String value;

  const CustomInfoWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color.fromRGBO(14, 12, 92, 1)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 34, 186, 1),
            Color.fromRGBO(9, 10, 19, 1),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 24, // Adjust image width as needed
              height: 24, // Adjust image height as needed
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.yellow,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
