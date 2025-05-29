import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:event_radar2/feature/authentication/presentation/cubits/cubit/auth_cubit.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/navigation_page.dart';
import 'package:event_radar2/network/notification_service.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp();
    NotificationService.instance.initialize();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final SecureStorageService secureStorageService = SecureStorageService();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final sessionExp = await secureStorageService.getSessionExp();

    await Future.delayed(const Duration(seconds: 1));

    if (isLoggedIn) {
      final now = DateTime.now();

      if (sessionExp != null && now.isBefore(sessionExp)) {
        // Session masih aktif
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NavigationPage()),
        );
      } else {
        await secureStorageService.clearStorage();
        for (String key in prefs.getKeys()) {
          if (key != "onboarding") {
            prefs.remove(key);
          }
        }

        UserStatus.isLoggedIn = false;
        UserStatus.isExpired = null;
        // Session expired: tampilkan login + bottom sheet
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => GetIt.instance<AuthCubit>(),
              child: LoginPage(),
            ),
          ),
        );

        // Delay sedikit agar login page sempat build sebelum bottom sheet muncul
        Future.delayed(const Duration(milliseconds: 500), () {
          BottomSheetUtils.displayResultBottomSheet(
              title: 'Session Expired',
              description:
                  'Your session has been expired. Please try to login again',
              image: 'asset/img/auth/session_expired.jpg',
              completion: 'Okay',
              onTap: () {
                Navigator.pop(context);
              },
              context: context);
        });
      }
    } else {
      // Belum login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetIt.instance<AuthCubit>(),
            child: LoginPage(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: <Color>[
            Color(0xff0022ba),
            Color(0xff0022ba),
            Color(0xff4f4cee),
            Color(0xff7f7df3)
          ],
          stops: <double>[0, 0, 0.531, 1],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/splash/logo_splash.png',
              width: 120.w,
              height: 127.h,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'EventRadar',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 36,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
