import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/feature/components/event/event_box.dart';
import 'package:event_radar2/feature/components/event/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: Colors.white,
        title: Text(
          'Searching',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20.sp),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 37.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: SizedBox(
                  width: double.infinity, // Ensures it takes the full width
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                )),
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
                    width: 37.w,
                    height: 37.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        border: Border.all(color: const Color(0xFF6E6E6E)),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset('asset/img/search/filter_search.png'),
                    ),
                  ),
                ),
                Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      border: Border.all(color: const Color(0xFF6E6E6E)),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset('asset/img/search/arrow_top_down.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
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
              fontSize: 15.sp,
              color: const Color(0xFF4E4E55),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
              searchSuggestionsItem('Lorem ipsum'),
            ],
          ),

          const SizedBox(
            height: 25,
          ),

          //Categories

          Text(
            'By Category',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: const Color(0xFF4E4E55),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),

          const SizedBox(
            height: 25,
          ),

          //Topic

          Text(
            'By Topic',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: const Color(0xFF4E4E55),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),

          const SizedBox(
            height: 25,
          ),

          //Region

          Text(
            'By Region',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: const Color(0xFF4E4E55),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
              searchCategoriesandRegionItem('Lorem ipsum'),
            ],
          ),
          const SizedBox(
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
    padding: EdgeInsets.all(12.0.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventDetail()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: const EventBox(),
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
    margin: EdgeInsets.only(left: 8.w),
    height: 32.h,
    width: 100.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFC7C7C7),
      ),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Colors.blue),
      ),
    ),
  );
}

searchCategoriesandRegionItem(String text) {
  return Container(
    margin: EdgeInsets.only(left: 8.w),
    height: 32.h,
    width: 100.w,
    decoration: BoxDecoration(
      color: const Color(0xFF90A3FF),
      border: Border.all(
        color: const Color(0xFF4F4CEE),
      ),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Colors.blue),
      ),
    ),
  );
}
