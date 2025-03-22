import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Spacer(),
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
                color: Color(0xFF231FFA),
                borderRadius: BorderRadius.circular(15.r)),
            child: Center(
              child: Text(
                'Apply Filters',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  searchSuggestionsItem(String text) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      height: 32.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFC7C7C7),
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                color: Colors.blue),
          ),
        ),
      ),
    );
  }

  searchCategoriesandRegionItem(String text) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      height: 32.h,
      decoration: BoxDecoration(
        color: const Color(0xFF90A3FF),
        border: Border.all(
          color: const Color(0xFF4F4CEE),
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
