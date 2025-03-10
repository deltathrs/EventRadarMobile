import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/feature/profile/presentation/widgets/custom_logo.dart';
import 'package:event_radar2/feature/profile/presentation/widgets/custom_payment_info.dart';
import 'package:event_radar2/feature/profile/presentation/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Profile',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage:
                      const AssetImage('asset/img/profile/avatar_circle.png'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Text(
                      'John James Doe',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: const Color(0xFF4E4E55),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'john.doe@gmail.com',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF4E4E55)),
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingScreen()));
                    },
                    child: Image.asset('asset/img/profile/settings_icon.png')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInfoWidget(
                    imagePath: 'asset/img/profile/badge.png',
                    title: 'Badge',
                    value: 'Gold'),
                SizedBox(
                  width: 5,
                ),
                CustomInfoWidget(
                    imagePath: 'asset/img/profile/active_point.png',
                    title: 'Active Point',
                    value: '3456'),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'My Events',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                  color: const Color(0xFF4E4E55)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/saved_icon.png',
                    text: 'Saved'),
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/registered_icon.png',
                    text: 'Registered'),
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/finished_icon.png',
                    text: 'Finished'),
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/certificate_icon.png',
                    text: 'Certificate'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
