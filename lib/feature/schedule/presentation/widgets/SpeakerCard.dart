import 'package:flutter/material.dart';

class DetailCardSpeaker extends StatefulWidget {
  const DetailCardSpeaker({
    super.key,
    required this.image,
    required this.name,
    required this.detailname,
    required this.jobdetail,
    // required this.seminarlist,
  });
  final String image;
  final String name;
  final String detailname;
  final String jobdetail;
  // final String seminarlist;

  @override
  State<DetailCardSpeaker> createState() => _DetailCardSpeakerState();
}

class _DetailCardSpeakerState extends State<DetailCardSpeaker> {
  bool isfollow = false;

  void following() {
    setState(() {
      isfollow = !isfollow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 20,
            color: Colors.grey,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                listScircleContent(
                  ontap: null,
                  showname: false,
                  imageSpeaker: widget.image,
                  name: "",
                ),
                Expanded(child: SizedBox()),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: TemplateColor.dark,
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () => following(),
                        child: Text(
                          isfollow ? "Followed" : "Follow",
                          style: Appstyle.styletext3,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.do_not_disturb_alt_outlined)
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              style: Appstyle.styletext2.copyWith(
                  fontWeight: FontWeight.bold, color: TemplateColor.textdark),
            ),
            Container(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: TemplateColor.dark,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                widget.detailname,
                style: Appstyle.styletext3,
              ),
            ),
            detailSpeakerText(
                widget.jobdetail)
          ],
        ),
      ),
    );
  }
}
