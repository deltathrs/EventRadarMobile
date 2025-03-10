import 'package:eventradar/models/speakerListModel.dart';
import 'package:eventradar/widgets/categorysearch.dart';
import 'package:eventradar/widgets/detail_Speaker/SpeakerCard.dart';
import 'package:eventradar/widgets/detail_Speaker/seminarcard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class detailSpeakerPage extends StatefulWidget {
  const detailSpeakerPage({
    super.key,
    required this.image,
    required this.name,
    required this.detailname,
    required this.jobdetail,
    required this.seminar,
  });
  final String image;
  final String name;
  final String detailname;
  final String? jobdetail;
  final List<SeminarListElement> seminar;

  @override
  State<detailSpeakerPage> createState() => _detailSpeakerPageState();
}

class _detailSpeakerPageState extends State<detailSpeakerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DetailCardSpeaker(
                  image: widget.image,
                  name: widget.name,
                  detailname: widget.detailname,
                  jobdetail: widget.jobdetail!,
                ),
                CategorySearch(),
                Divider(),
                ResponsiveGridList(
                    listViewBuilderOptions: ListViewBuilderOptions(
                      shrinkWrap: true,
                    ),
                    minItemWidth: 120,
                    children: List.generate(
                      widget.seminar.length,
                      (index) => SeminarCard(
                        title: widget.seminar[index].title,
                        moda: widget.seminar[index].moda,
                        date: widget.seminar[index].date.toIso8601String(),
                        time: widget.seminar[index].time,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
