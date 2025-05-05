import 'package:event_radar2/feature/home/presentation/cubits/ad_slider/ad_slider_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/events/events_cubit.dart';
import 'package:event_radar2/feature/home/presentation/screen/home_screen.dart';
import 'package:event_radar2/feature/notification/presentation/screens/notification_page.dart';
import 'package:event_radar2/feature/profile/presentation/screen/profile.dart';
import 'package:event_radar2/feature/schedule/presentation/screens/schedule_page.dart';
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
          MultiBlocProvider(
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
          const SchedulePage(),
          const NotificationPage(),
          const ProfilePage(),
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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          activeIcon: Icon(Icons.person_2_sharp),
          label: 'Profile',
        ),
      ],
    );
  }
}
