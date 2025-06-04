import 'package:event_radar2/feature/authentication/presentation/cubits/cubit/auth_cubit.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/register_screen.dart';
import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/main.dart';
import 'package:event_radar2/navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../widgets/auth_textfield.dart';
import '../widgets/service_button.dart';
import '../widgets/sign_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordDisable = true;
  final AuthCubit _cubit = GetIt.instance<AuthCubit>();

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Center(
                child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }

          if (state is GoogleLoginLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }

          if (state is GoogleLoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavigationPage()),
              (Route<dynamic> route) => false,
            );
          }

          if (state is GoogleLoginFailed) {
            Navigator.pop(context);
          }

          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavigationPage()),
              (Route<dynamic> route) => false,
            );
          }

          if (state is LoginFailed) {
            Navigator.pop(context);
            BottomSheetUtils.displayResultBottomSheet(
                title: "Login Failed",
                description: state.error.contains("-")
                    ? state.error.split("-").last.trim()
                    : state.error,
                image: 'asset/img/event/failed.jpg',
                completion: "Try Again",
                onTap: () {
                  Navigator.pop(context);
                },
                context: context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Image.asset(
                    'asset/img/auth/app_logo.png',
                    height: 59.h,
                    width: 59.w,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome Back,",
                  style: TextStyle(
                      fontSize: 36.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "sign in to continue",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //email field
                      AuthTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        prefixIcon:
                            Image.asset('asset/img/auth/email_icon.png'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //username field
                      AuthTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: isPasswordDisable,
                        prefixIcon: Image.asset('asset/img/auth/key_icon.png'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordDisable
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordDisable = !isPasswordDisable;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onTap: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      _cubit.login(
                          emailController.text, passwordController.text);
                    } else {
                      BottomSheetUtils.displayResultBottomSheet(
                          title: "Login Failed",
                          description: "Please Fill All the required fields",
                          image: 'asset/img/event/failed.jpg',
                          completion: "Try Again",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          context: context);
                    }
                  },
                  text: 'Sign In',
                  color: Colors.blue,
                ),

                const SizedBox(
                  height: 15,
                ),

                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ServiceButton(
                    onTap: () {
                      _cubit.googleLogin();
                    },
                    text: 'Continue With Google',
                    color: Colors.white),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No account yet?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        ' Create one',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: Colors.black, // Default color
                        ),
                        children: const [
                          TextSpan(
                            text:
                                'You can learn more about out privacy practices and how we use your information in our ',
                          ),
                          TextSpan(
                            text: 'Privacy Notice.',
                            style: TextStyle(
                              color: Colors
                                  .blue, // Blue color for "Privacy Notice"
                            ),
                          ),
                          TextSpan(
                            text:
                                ' By creating an account, I confirm that I have read and agreed to the ',
                          ),
                          TextSpan(
                            text: 'Terms of Use.',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
