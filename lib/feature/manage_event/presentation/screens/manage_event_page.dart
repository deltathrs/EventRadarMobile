import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageEventPage extends StatefulWidget {
  const ManageEventPage({Key? key}) : super(key: key);

  @override
  _ManageEventPageState createState() => _ManageEventPageState();
}

class _ManageEventPageState extends State<ManageEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'My Events',
          style: GoogleFonts.poppins(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('Manage Event Page'),
      ),
    );
  }
}
