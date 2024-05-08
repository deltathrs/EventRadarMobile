import 'package:event_radar2/pages/event/event_box.dart';
import 'package:event_radar2/pages/event/event_detail.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late bool condition;
  late bool condition2;

  @override
  void initState() {
    condition = false;
    condition2 = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            'Searching',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 274,
                    height: 37,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF6E6E6E)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        condition = !condition;
                        condition2 = !condition2;
                        print(condition);
                        print(condition2);
                      });
                    },
                    child: Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          border: Border.all(color: Color(0xFF6E6E6E)),
                          shape: BoxShape.circle),
                      child: Center(
                        child:
                            Image.asset('asset/img/search/filter_search.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        border: Border.all(color: Color(0xFF6E6E6E)),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset('asset/img/search/arrow_top_down.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (condition2) EventList(),
              if (condition) FilterSearch(),
            ],
          ),
        ),
      ),
    );
  }

  FilterSearch() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search history',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF4E4E55),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
            ],
          ),

          SizedBox(
            height: 25,
          ),

          //Categories

          Text(
            'By Category',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF4E4E55),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),

          SizedBox(
            height: 25,
          ),

          //Topic

          Text(
            'By Topic',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF4E4E55),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),

          SizedBox(
            height: 25,
          ),

          //Region

          Text(
            'By Region',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF4E4E55),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
        ],
      ),
    );
  }
}

EventList() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventDetail()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EventBox(),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}

searchSuggestionsItem(String text) {
  return Container(
    margin: EdgeInsets.only(left: 8),
    height: 32,
    width: 100,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xFFC7C7C7),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: Colors.blue),
      ),
    ),
  );
}

searchCategoriesandRegionItem(String text) {
  return Container(
    margin: EdgeInsets.only(left: 8),
    height: 32,
    width: 100,
    decoration: BoxDecoration(
      color: Color(0xFF90A3FF),
      border: Border.all(
        color: Color(0xFF4F4CEE),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: Colors.blue),
      ),
    ),
  );
}
