import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_box.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_detail.dart';
import 'package:event_radar2/feature/home/presentation/cubits/events/events_cubit.dart';
import 'package:event_radar2/feature/home/presentation/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> filterList = [];
  bool? isOnline;

  @override
  void initState() {
    super.initState();
  }

  void _onFilterApplied(List<String> filters, bool isOn) {
    setState(() {
      filterList = filters;
      isOnline = isOn;
    });

    context.read<EventsCubit>().updateFilters(
        name: searchController.text,
        isOnline: isOnline,
        categories: filterList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          preferredSize: Size(double.infinity, 50.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      context.read<EventsCubit>().updateFilters(
                          name: searchController.text,
                          isOnline: isOnline,
                          categories: filterList);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
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
                ),
                SizedBox(
                  width: 5,
                ),
                FilterWidget(
                    categories: filterList, onFilterApplied: _onFilterApplied),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: eventList(),
      ),
    );
  }

  Widget eventList() {
    return RefreshIndicator(
      color: const Color.fromARGB(255, 21, 112, 239),
      backgroundColor: Colors.white,
      onRefresh: () => Future.sync(() => context.read<EventsCubit>().refresh()),
      child: PagedListView(
          pagingController: context.read<EventsCubit>().pagingController,
          builderDelegate: PagedChildBuilderDelegate<EventModel>(
            itemBuilder: (context, item, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) =>
                                    GetIt.instance<EventDetailCubit>(),
                                child: EventDetail(
                                  eventId: item.id,
                                ),
                              )));
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: BlocProvider(
                    create: (context) => GetIt.instance<FavouriteEventCubit>(),
                    child: EventBox(
                      eventData: item,
                    ),
                  ),
                ),
              );
            },
            noMoreItemsIndicatorBuilder: (context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("No more data",
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("No data found",
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("Error loading data",
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          )),
    );
  }
}
