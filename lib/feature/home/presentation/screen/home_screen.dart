import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_radar2/feature/components/utils/url_launcher_utils.dart';
import 'package:event_radar2/feature/home/presentation/cubits/ad_slider/ad_slider_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/creator_list/creator_list_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_transaction/event_transaction_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/home/presentation/screen/chat_screen.dart';
import 'package:event_radar2/feature/home/presentation/screen/eo_detail_screen.dart';
import 'package:event_radar2/feature/home/presentation/widgets/homepage_eventcard.dart';
import 'package:event_radar2/feature/home/presentation/widgets/homepage_speakers.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_detail.dart';
import 'package:event_radar2/feature/home/presentation/cubits/events/events_cubit.dart';
import 'package:event_radar2/feature/home/presentation/screen/search_screen.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventsCubit cubit = GetIt.instance<EventsCubit>();

  @override
  void initState() {
    cubit.getEventList();
    context.read<AdSliderCubit>().getAdSliderList();
    context.read<CreatorListCubit>().getEventOrganizer();
    super.initState();
  }

  final String baseUrlImage = dotenv.env['BASE_URL']!;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  int adIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r)),
          child: AppBar(
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              elevation: 0,
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) =>
                                    GetIt.instance<EventsCubit>(),
                                child: const SearchScreen(),
                              )));
                },
                child: Container(
                  height: 37.h,
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
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            carousel(),
            sectionTitle("Trending Events",
                image: Image.asset('asset/img/homepage/fire_icon.png')),
            homepageEvents(),
            sectionTitle(
              "Event Creators",
            ),
            homepageSpeakers(),
            // sectionTitle("Most Followed Communities",
            //     Image.asset('asset/img/homepage/fire_icon.png')),
            // homepageComunities(),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const ChatScreen(),
      //       ),
      //     );
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Color(0xFF231FEA),
      //       borderRadius: BorderRadius.circular(12.r),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.chat_bubble_outline,
      //             color: Colors.white,
      //             size: 24.sp,
      //           ),
      //           SizedBox(width: 8.w),
      //           Text(
      //             'RadarBot',
      //             style: TextStyle(
      //               fontFamily: 'Poppins',
      //               fontWeight: FontWeight.w600,
      //               fontSize: 14.sp,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget carousel() {
    return BlocBuilder<AdSliderCubit, AdSliderState>(
      builder: (context, state) {
        if (state is AdSliderLoaded) {
          return Stack(
            children: [
              InkWell(
                onTap: () {
                  print(adIndex);
                },
                child: CarouselSlider(
                    items: state.adSliderList
                        .map((item) => GestureDetector(
                              onTap: () {
                                UrlLauncherUtils.launchURL(
                                    actionType: 'browser', value: item.adUrl);
                              },
                              child: Image.network(
                                "$baseUrlImage${item.image}",
                                width: 430.w,
                                height: 196.h,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'asset/img/event/placeholder.jpg',
                                    width: 430.w,
                                    height: 196.h,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ))
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
                  children: state.adSliderList.asMap().entries.map((entry) {
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
                          color:
                              adIndex == entry.key ? Colors.blue : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 196.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      },
    );
  }

  Widget homepageComunities() {
    return SizedBox(
      width: 400.w,
      height: 100.h,
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
    );
  }

  Widget homepageEvents() {
    return BlocBuilder<EventsCubit, EventsState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is EventListLoaded) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: SizedBox(
              height: 310.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => GetIt.instance<
                                              EventDetailCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) => GetIt.instance<
                                              EventTransactionCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) => GetIt.instance<
                                              ManageEventCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) => GetIt.instance<
                                              FavouriteEventCubit>(),
                                        ),
                                      ],
                                      child: EventDetail(
                                        eventId: state.events[index].id,
                                      ),
                                    )));
                      },
                      child: HomepageEventCard(
                        title: state.events[index].name,
                        image:
                            "$baseUrlImage${state.events[index].eventThumbnail}",
                        eventDate: state.events[index].datetime,
                        eventType:
                            state.events[index].isOnline ? "Online" : "Onsite",
                        eventCategory: state.events[index].categories,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return SizedBox(
          height: 200.h,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 175.w,
                      height: 226.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget homepageSpeakers() {
    return BlocBuilder<CreatorListCubit, CreatorListState>(
      builder: (context, state) {
        if (state is CreatorListLoaded) {
          // Filter EO list yang profile-nya tidak kosong
          final filteredEoList =
              state.eoList.where((eo) => eo.profile.trim().isNotEmpty).toList();

          return SizedBox(
            width: 400.w,
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredEoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          GetIt.instance<CreatorListCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          GetIt.instance<FavouriteEventCubit>(),
                                    ),
                                  ],
                                  child: EoDetailScreen(
                                      eoModel: filteredEoList[index],
                                      eoImage:
                                          '$baseUrlImage${filteredEoList[index].profile}'),
                                )));
                  },
                  child: HomepageProfile(
                    image: Image.network(
                        '$baseUrlImage${filteredEoList[index].profile}'),
                    name: filteredEoList[index].fullname,
                  ),
                );
              },
            ),
          );
        }

        return SizedBox(
          height: 100.h,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 59.w,
                        height: 59.h,
                        padding: const EdgeInsets.all(.5),
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      )),
                );
              }),
        );
      },
    );
  }

  Widget sectionTitle(String text, {Image? image}) {
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
          image ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
