import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:event_radar2/feature/authentication/presentation/cubits/cubit/auth_cubit.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/navigation_page.dart';
import 'package:event_radar2/network/notification_service.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => isLoggedIn == true
              ? const NavigationPage()
              : BlocProvider(
                  create: (context) => GetIt.instance<AuthCubit>(),
                  child: LoginPage(),
                )));
    });
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
            Image.asset('asset/img/splash/logo_splash.png'),
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
