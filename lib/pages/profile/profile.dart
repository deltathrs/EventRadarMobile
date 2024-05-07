import 'package:event_radar2/components/profile/custom_logo.dart';
import 'package:event_radar2/components/profile/custom_payment_info.dart';
import 'package:event_radar2/pages/profile/settings.dart';
import 'package:flutter/material.dart';

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
            SizedBox(
              height: 10,
            ),
            Text(
              'Profile',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('asset/img/profile/avatar_circle.png'),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Text(
                      'John James Doe',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xFF4E4E55),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'john.doe@gmail.com',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4E4E55)),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                    child: Image.asset('asset/img/profile/settings_icon.png')),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
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
            SizedBox(
              height: 25,
            ),
            Text(
              'My Events',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Color(0xFF4E4E55)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/saved_icon.png',
                    text: 'Saved'),
                SizedBox(
                  width: 4,
                ),
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/registered_icon.png',
                    text: 'Registered'),
                SizedBox(
                  width: 4,
                ),
                CustomLogoWidget(
                    imagePath: 'asset/img/profile/finished_icon.png',
                    text: 'Finished'),
                SizedBox(
                  width: 4,
                ),
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
