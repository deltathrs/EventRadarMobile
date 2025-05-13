import 'package:event_radar2/feature/home/presentation/cubits/ad_slider/ad_slider_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/events/events_cubit.dart';
import 'package:event_radar2/feature/home/presentation/screen/home_screen.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/event/event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/screens/my_event_page.dart';
import 'package:event_radar2/feature/notification/presentation/screens/notification_page.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/screen/profile.dart';
import 'package:event_radar2/feature/schedule/presentation/screens/schedule_page.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int currentPageIndex = 0;
  String userRole = "";
  final SecureStorageService secureStorageService = SecureStorageService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp();
  }

  void initializeApp() async {
    final role = await secureStorageService.getUserRole();
    setState(() {
      userRole = role ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          userRole == 'organizer'
              ? BlocProvider(
                  create: (context) => GetIt.instance<EventCubit>(),
                  child: MyEventPage(),
                )
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetIt.instance<EventsCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => GetIt.instance<AdSliderCubit>(),
                    ),
                  ],
                  child: const HomePage(),
                ),
          BlocProvider(
            create: (context) => GetIt.instance<ProfileCubit>(),
            child: const SchedulePage(),
          ),
          const NotificationPage(),
          BlocProvider(
            create: (context) => GetIt.instance<ProfileCubit>(),
            child: const ProfilePage(),
          ),
        ],
      ),
    );
  }

  Widget buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10.r,
            spreadRadius: 1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: buildNavigationBarWidget(currentPageIndex),
    );
  }

  Widget buildNavigationBarWidget(int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.black,
      // showUnselectedLabels: false,
      onTap: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: userRole == 'organizer'
              ? Icon(Icons.manage_history)
              : Icon(Icons.home_outlined),
          activeIcon: userRole == 'organizer'
              ? const Icon(Icons.manage_history_rounded)
              : const Icon(Icons.home_filled),
          label: userRole == 'organizer' ? "Your Event" : 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Schedule',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          activeIcon: Icon(Icons.person_2_sharp),
          label: 'Profile',
        ),
      ],
    );
  }
}
