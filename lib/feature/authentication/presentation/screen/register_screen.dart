import 'package:event_radar2/feature/authentication/presentation/cubits/cubit/auth_cubit.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../widgets/auth_textfield.dart';
import '../widgets/sign_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool? isAgree = false;
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
              style: const TextStyle(
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is RegisterLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }

          if (state is RegisterSuccess) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.green,
                  title: Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                          Navigator.pop(
                              context); // Kembali ke halaman sebelumnya
                          //  Navigator.pushReplacement(context, Materi)
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          if (state is RegisterFailed) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Center(
                        child: Text(
                      state.error,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  );
                });
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      'asset/img/auth/app_logo.png',
                      height: 59,
                      width: 59,
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
                        Row(
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        //name field
                        AuthTextField(
                          controller: fullNameController,
                          hintText: 'Full Name',
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        //password field
                        AuthTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          prefixIcon:
                              Image.asset('asset/img/auth/key_icon.png'),
                          suffixIcon: const Icon(Icons.remove_red_eye),
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
                        Row(
                          children: [
                            Text(
                              "Confirm Password",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        //confirm password field
                        AuthTextField(
                          controller: confirmPasswordController,
                          hintText: 'Re-enter Password',
                          obscureText: true,
                          prefixIcon:
                              Image.asset('asset/img/auth/key_icon.png'),
                          suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isAgree,
                          activeColor: Colors.blue,
                          tristate: false,
                          onChanged: (newBool) {
                            setState(() {
                              isAgree = newBool;
                            });
                          }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "By checking the box, you agree to our ",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Terms & Conditions.",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                    onTap: () {
                      _cubit.register(emailController.text,
                          fullNameController.text, passwordController.text);
                    },
                    text: 'Sign Up',
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          ' Sign In',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
