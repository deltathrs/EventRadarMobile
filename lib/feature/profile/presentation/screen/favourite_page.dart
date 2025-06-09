import 'package:event_radar2/feature/components/utils/empty_data_utils.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_transaction/event_transaction_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_box.dart';
import 'package:event_radar2/feature/home/presentation/widgets/event_detail.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouriteEventCubit>().getFavouriteEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Events',
          style: GoogleFonts.poppins(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: BlocBuilder<FavouriteEventCubit, FavouriteEventState>(
        builder: (context, state) {
          if (state is FavouriteEventLoaded) {
            if (state.favouriteList.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.favouriteList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
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
                                                FavouriteEventCubit>(),
                                          ),
                                          BlocProvider(
                                            create: (context) => GetIt.instance<
                                                ManageEventCubit>(),
                                          ),
                                        ],
                                        child: EventDetail(
                                          eventId:
                                              state.favouriteList[index].id,
                                        ),
                                      )));
                        },
                        child: EventBox(
                          eventData: state.favouriteList[index],
                          isFavoritePage: true,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: EmptyDataUtils().emptyDataWithoutButton(
                    "Your Favourite Event is Empty",
                    "Start adding events you love to keep them here",
                    "asset/img/event/empty_data.jpg"),
              );
            }
          }
          return SizedBox(
            height: 500.h,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 388.w,
                        height: 141.h,
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
      ),
    );
  }
}
