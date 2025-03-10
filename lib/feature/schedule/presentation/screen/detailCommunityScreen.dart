import 'package:event_radar2/feature/schedule/presentation/widgets/communitiesCard.dart';
import 'package:event_radar2/feature/schedule/presentation/widgets/seminarcard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class DetailCommunityScreen extends StatefulWidget {
  final String image;
  final String name;
  final String jobdetail;
  // final List<Semina>
  const DetailCommunityScreen({
    super.key,
    required this.image,
    required this.name,
    required this.jobdetail,
  });

  @override
  State<DetailCommunityScreen> createState() => _DetailCommunityScreenState();
}

class _DetailCommunityScreenState extends State<DetailCommunityScreen> {
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
                Communitiescard(
                  image: widget.image,
                  name: widget.name,
                  jobdetail: widget.jobdetail,
                ),
                Divider(),
                ResponsiveGridList(
                  listViewBuilderOptions: ListViewBuilderOptions(
                    shrinkWrap: true,
                  ),
                  minItemWidth: 120,
                  children: List.generate(
                    1,
                    (index) =>  SeminarCard(
                      title: "Judul",
                      moda: "Moda",
                      date: "7 Agustus 2024",
                      time: "07.00",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
