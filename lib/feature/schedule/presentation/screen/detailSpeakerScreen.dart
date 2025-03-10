import 'package:event_radar2/feature/schedule/presentation/widgets/SpeakerCard.dart';
import 'package:event_radar2/feature/schedule/presentation/widgets/seminarcard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class detailSpeakerPage extends StatefulWidget {
  final String image;
  final String name;
  final String detailname;
  final String jobdetail;
  const detailSpeakerPage({
    super.key,
    required this.image,
    required this.name,
    required this.detailname,
    required this.jobdetail,
  });

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
                  jobdetail: widget.jobdetail,
                ),
                // CategorySearch(),
                Divider(),
                ResponsiveGridList(
                    listViewBuilderOptions: ListViewBuilderOptions(
                      shrinkWrap: true,
                    ),
                    minItemWidth: 120,
                    children: List.generate(
                      2,
                      (index) => SeminarCard(
                        title: "Judul",
                        moda: "Moda",
                        date: "7 Agustus 2024",
                        time: "07.00",
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
