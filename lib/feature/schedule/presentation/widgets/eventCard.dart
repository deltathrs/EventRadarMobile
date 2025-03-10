import 'package:eventradar/appStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Eventcard extends StatelessWidget {
  const Eventcard({
    super.key,
    required this.seminarTime,
    required this.seminarTitle,
    required this.seminarDesc,
    required this.seminarModa,
  });
  final String seminarTime;
  final String seminarTitle;
  final String seminarDesc;
  final String seminarModa;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 180,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1),
            right: BorderSide(width: 1),
            top: BorderSide(width: 1),
            left: BorderSide(width: 5),
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            // spacing: 5
            children: [
              Icon(CupertinoIcons.cube),
              Text(
                seminarTime,
                style: Appstyle.regisText.copyWith(fontSize: 15),
              )
            ],
          ),
          Text(
            seminarTitle,
            style: Appstyle.styletext1.copyWith(fontSize: 20),
          ),
          Text(
            seminarDesc,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: Appstyle.styletext2,
          ),
          Row(
            spacing: 8,
            children: [
              Icon(CupertinoIcons.location),
              Text(
                seminarModa,
                style: Appstyle.styletext2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
