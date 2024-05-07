import 'package:flutter/material.dart';

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
              fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.w600),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListProfile('Edit Profile'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Notifications'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Language'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Privacy'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Security and Permissions'),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 13,
                color: Color(0xFFF0F0F0),
              ),

              SizedBox(
                height: 10,
              ),

              //Support
              Text(
                'Support',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListProfile('About App'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Help & Support'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Privacy Policy'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Terms & Conditions'),
                    SizedBox(
                      height: 5,
                    ),
                    ListProfile('Rate Us'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 13,
                      color: Color(0xFFF0F0F0),
                    ),
                    SizedBox(
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E4E55)),
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
