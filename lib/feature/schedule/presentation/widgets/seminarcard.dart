import 'package:flutter/material.dart';

class SeminarCard extends StatefulWidget {
  const SeminarCard(
      {super.key,
      required this.title,
      required this.date,
      required this.time,
      required this.moda});

  final String title;
  final String date;
  final String time;
  final String moda;
  @override
  State<SeminarCard> createState() => _SeminarCardState();
}

class _SeminarCardState extends State<SeminarCard> {
  bool isbookmarked = false;

  void bookmarkClick() {
    setState(() {
      isbookmarked = !isbookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 15,
              color: Colors.grey,
            )
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset('lib/images/image1.png', fit: BoxFit.cover),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: bookmarkClick,
                    child: Icon(isbookmarked == false
                        ? Icons.bookmark_outline_rounded
                        : Icons.bookmark_outlined),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        widget.title,
                        style: Appstyle.styletext4,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                          color: TemplateColor.light,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        widget.moda,
                        style: Appstyle.styletext6,
                      ),
                    )
                  ],
                ),
                Text(
                  widget.date,
                  style: Appstyle.styletext5,
                ),
                Text(
                  widget.time,
                  style: Appstyle.styletext5,
                ),
                Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TemplateColor.defaultColor),
                    onPressed: () {},
                    child: Text(
                      "Checkout",
                      style: Appstyle.styletext4.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
