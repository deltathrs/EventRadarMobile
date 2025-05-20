import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EoDetailScreen extends StatefulWidget {
  final ListEoModel eoModel;
  final String eoImage;
  const EoDetailScreen({Key? key, required this.eoModel, required this.eoImage})
      : super(key: key);

  @override
  _EoDetailScreenState createState() => _EoDetailScreenState();
}

class _EoDetailScreenState extends State<EoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Organizer Details',
          style: GoogleFonts.poppins(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              eoDetailBox(),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 item per baris
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 2, // sesuaikan rasio lebar:tinggi
                ),
                itemCount: 4, // jumlah item
                itemBuilder: (context, index) {
                  return Container(
                      width: 167.w,
                      height: 254.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // shadow color
                              blurRadius: 5, // soften the shadow
                              offset: Offset(0, 4), // move down (x, y)
                              spreadRadius: 2, // extend the shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 167.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22.r)),
                              child: Image.network(
                                widget.eoImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Tambahkan konten lain di bawah sini
                        ],
                      ));
                },
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // opsional, jika dalam Column
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container eoDetailBox() {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // shadow color
            blurRadius: 5, // soften the shadow
            offset: Offset(0, 4), // move down (x, y)
            spreadRadius: 2, // extend the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.eoImage),
                  radius: 32.r,
                ),
                Image.asset(
                  'asset/img/event_organizer/whatsapp.png',
                  width: 30.w,
                  height: 30.h,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.eoModel.fullname,
              style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF231FEA),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  widthFactor: 1.0,
                  child: Text(
                    widget.eoModel.domicile,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   widget.eoModel.email,
            //   style: GoogleFonts.inter(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black),
            // )
          ],
        ),
      ),
    );
  }
}
