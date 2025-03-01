import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 32.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListProfile('Edit Profile'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Notifications'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Language'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Privacy'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Security and Permissions'),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 13,
                color: const Color(0xFFF0F0F0),
              ),

              const SizedBox(
                height: 10,
              ),

              //Support
              Text(
                'Support',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListProfile('About App'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Help & Support'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Privacy Policy'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Terms & Conditions'),
                    const SizedBox(
                      height: 5,
                    ),
                    ListProfile('Rate Us'),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 13.h,
                      color: const Color(0xFFF0F0F0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListProfile('Logout'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding ListProfile(String text) {
    return Padding(
      padding:  EdgeInsets.all(8.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4E4E55)),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
