import 'dart:io';

import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/feature/components/utils/input_dropdown_utils.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile_avatar/profile_avatar_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/save_profile/save_profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/widgets/input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController domicileController = TextEditingController();
  String? selectedCity;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  final String baseUrlImage = dotenv.env['BASE_URL']!;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        context.read<ProfileAvatarCubit>().changeProfileAvatar(_image!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SaveProfileCubit>().saveProfile(
                      nameController.text,
                      phoneController.text,
                      selectedCity ?? "");
                },
                icon: Text(
                  'SAVE',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF231FEA)),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: MultiBlocListener(
            listeners: [
              BlocListener<ProfileAvatarCubit, ProfileAvatarState>(
                listener: (context, state) {
                  if (state is ChangeProfileAvatarLoading) {
                    BottomSheetUtils.showLoadingDialog(context);
                  }

                  if (state is ChangeProfileAvatarSuccess) {
                    Navigator.pop(context);
                    context.read<ProfileCubit>().getProfile();
                  }

                  if (state is ChangeProfileAvatarFailed) {
                    Navigator.pop(context);
                    BottomSheetUtils.displayResultBottomSheet(
                        title: "Edit Profile Failed",
                        description: state.error.contains("-")
                            ? state.error.split("-").last.trim()
                            : state.error,
                        image: "asset/img/event/failed.jpg",
                        completion: "Try Again",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        context: context);
                  }
                },
              ),
              BlocListener<SaveProfileCubit, SaveProfileState>(
                listener: (context, state) async {
                  if (state is SaveProfileLoading) {
                    BottomSheetUtils.showLoadingDialog(context);
                  }

                  if (state is SaveProfileSuccess) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }

                  if (state is SaveProfileFailed) {
                    Navigator.pop(context);
                    BottomSheetUtils.displayResultBottomSheet(
                        title: "Edit Profile Failed",
                        description: state.error.contains("-")
                            ? state.error.split("-").last.trim()
                            : state.error,
                        image: "asset/img/event/failed.jpg",
                        completion: "Try Again",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        context: context);
                  }

                  if (state is LogoutLoading) {
                    BottomSheetUtils.showLoadingDialog(context);
                  }

                  if (state is LogoutSuccess) {
                    Navigator.pop(context);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    FlutterSecureStorage secureStorage = FlutterSecureStorage();

                    for (String key in prefs.getKeys()) {
                      if (key != "onboarding") {
                        prefs.remove(key);
                      }
                    }
                    secureStorage.deleteAll();

                    print(prefs.getBool('onboarding'));

                    UserStatus.isLoggedIn = false;
                    UserStatus.isExpired = null;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  }

                  if (state is LogoutFailed) {
                    Navigator.pop(context);
                    BottomSheetUtils.displayResultBottomSheet(
                        title: "Failed to Register User",
                        description: state.error.contains("-")
                            ? state.error.split("-").last.trim()
                            : state.error,
                        image: "asset/img/event/failed.jpg",
                        completion: "Try Again",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        context: context);
                  }
                },
              ),
            ],
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  nameController =
                      TextEditingController(text: state.profile.fullname);
                  emailController =
                      TextEditingController(text: state.profile.email);
                  if (state.profile.domicile.isEmpty) {
                    selectedCity = null;
                  } else {
                    selectedCity = state.profile.domicile;
                  }
                  phoneController =
                      TextEditingController(text: state.profile.phoneNumber);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                state.profile.profileGoogle.isNotEmpty
                                    ? state.profile.profileGoogle
                                    : "$baseUrlImage${state.profile.profile}",
                              ),
                              onBackgroundImageError: (_, __) {
                                AssetImage(
                                    'assets/img/common/placeholder_avatar.jpeg');
                              },
                              radius: 60.r,
                            ),
                            Positioned(
                              bottom: 1.h,
                              right: 1.w,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  width: 28.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 22.w,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        InputTextfield(
                            label: "Full Name",
                            hint: state.profile.fullname,
                            isRequired: true,
                            controller: nameController),
                        SizedBox(
                          height: 10,
                        ),
                        InputTextfield(
                            label: "Email",
                            hint: "deltatherof@gmail.com",
                            isReadOnly: true,
                            controller: emailController),
                        SizedBox(
                          height: 10,
                        ),
                        InputTextfield(
                            label: "Whatsapp Number",
                            hint: "8XXXXXXXXXX",
                            isPhoneNumber: true,
                            controller: phoneController),
                        SizedBox(
                          height: 10,
                        ),
                        InputDropdownUtils<String>(
                          label: 'Domicile',
                          hint: 'Select domicile',
                          isRequired: true,
                          isReadOnly: false,
                          value: selectedCity,
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value!;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                                value: 'Jakarta', child: Text('Jakarta')),
                            DropdownMenuItem(
                                value: 'Bandung', child: Text('Bandung')),
                            DropdownMenuItem(
                                value: 'Surabaya', child: Text('Surabaya')),
                            DropdownMenuItem(
                                value: 'Medan', child: Text('Medan')),
                            DropdownMenuItem(
                                value: 'Semarang', child: Text('Semarang')),
                            DropdownMenuItem(
                                value: 'Yogyakarta', child: Text('Yogyakarta')),
                          ],
                        ),

                        // InputTextfield(
                        //     label: "Domicile",
                        //     hint: "Jakarta",
                        //     controller: domicileController),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<SaveProfileCubit>().logout();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
