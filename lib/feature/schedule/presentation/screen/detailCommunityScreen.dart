import 'package:eventradar/models/communitiesListModel.dart';
import 'package:eventradar/widgets/categorysearch.dart';
import 'package:eventradar/widgets/detail_Communities/communitiesCard.dart';
import 'package:eventradar/widgets/detail_Speaker/seminarcard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class detailCommunityPage extends StatefulWidget {
  const detailCommunityPage({
    super.key,
    required this.image,
    required this.name,
    required this.jobdetail,
    required this.seminar,
  });
  final String image;
  final String name;
  final String? jobdetail;
  final List<SeminarList> seminar;

  @override
  State<detailCommunityPage> createState() => _detailCommunityPageState();
}

class _detailCommunityPageState extends State<detailCommunityPage> {
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
                      date: widget.seminar[index].date,
                      time: widget.seminar[index].time,
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
