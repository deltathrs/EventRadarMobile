import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageProfile extends StatelessWidget {
  final Image image;
  final String name;

  const HomepageProfile({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 8.w),
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 59.w,
                height: 59.h,
                padding: const EdgeInsets.all(.5),
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                child: ClipOval(child: image),
              ),
              const SizedBox(height: 4),
              Text(overflow: TextOverflow.ellipsis, name),
            ],
          ),
        ),
      ),
    );
  }
}
