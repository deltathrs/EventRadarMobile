import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/feature/components/homepage/homepage_eventcard.dart';
import 'package:event_radar2/feature/components/homepage/homepage_speakers.dart';
import 'package:event_radar2/feature/components/event/event_detail.dart';
import 'package:event_radar2/feature/home/presentation/screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List imageList = [
    {"id": 1, "image_path": 'asset/img/homepage/adpage1.png'},
    {"id": 2, "image_path": 'asset/img/homepage/adpage2.png'},
  ];

  final user = FirebaseAuth.instance.currentUser!;

  //sign out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  int adIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            child: Container(
              height: 37.h,
              width: 378.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6E6E6E)),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Search public speaking webinar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: const Color(0xFF6E6E6E),
                    ),
                  )
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            carousel(),
            sectionTitle("Trending Events",
                Image.asset('asset/img/homepage/fire_icon.png')),
            homepageEvents(),
            sectionTitle("Popular Speakers",
                Image.asset('asset/img/homepage/fire_icon.png')),
            homepageSpeakers(),
            sectionTitle("Most Followed Communities",
                Image.asset('asset/img/homepage/fire_icon.png')),
            homepageComunities(),
          ],
        ),
      ),
    );
  }

  Widget carousel() {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            print(adIndex);
          },
          child: CarouselSlider(
              items: imageList
                  .map(
                    (item) => Image.asset(
                      item["image_path"],
                      fit: BoxFit.fill,
                      width: 430,
                      height: 196,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      adIndex = index;
                    });
                  })),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              print(entry);
              print(entry.key);
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  height: 8.h,
                  width: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: adIndex == entry.key ? Colors.blue : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget homepageComunities() {
    return SizedBox(
      width: 400.w,
      height: 100.h,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return HomepageProfile(
              image: Image.asset('asset/img/homepage/comunity1.png'),
              name: "John Doe $index",
            );
          },
        ),
      ),
    );
  }

  Widget homepageEvents() {
    return SizedBox(
      height: 310.h,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3, // Number of items you want to display
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EventDetail()));
              },
              child: HomepageEventCard(
                title: "Public Speaking Webinar",
                image: Image.asset('asset/img/homepage/event1.png'),
                lastRegistrationDate: DateTime.now(),
                eventDate: DateTime.now(),
                eventType: "Webinar",
                eventCategory: ["Public Speaking", "Webinar"],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homepageSpeakers() {
    return SizedBox(
      width: 400.w,
      height: 100.h,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return HomepageProfile(
              image: Image.asset('asset/img/homepage/speaker1.png'),
              name: "John Doe $index",
            );
          },
        ),
      ),
    );
  }

  Widget sectionTitle(String text, Image image) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 22.w, bottom: 20.h),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: Colors.black,
            ),
          ),
          image,
        ],
      ),
    );
  }
}
