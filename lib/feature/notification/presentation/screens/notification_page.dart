import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B1B25)),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return buildNotificationItem(
                  'Event Title $index', 'Event Description $index', '12 Maret');
            }),
      ),
    );
  }

  Widget buildNotificationItem(String title, String description, String date) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: CircleAvatar(
        radius: 24.r,
        backgroundColor: Color(0xFFD3E1FF),
        child: Image.asset(
          'asset/img/event/notif.png',
          width: 26.w,
          height: 26.h,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Konten teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E2E2E)),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.nunito(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF2E2E2E)),
                ),
              ],
            ),
          ),
          // Tanggal di pojok kanan atas
          Text(
            date,
            style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E2E2E)),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
