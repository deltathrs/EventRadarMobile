import 'package:event_radar2/feature/home/presentation/cubits/favourite_event/favourite_event_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/profile_avatar/profile_avatar_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/cubits/save_profile/save_profile_cubit.dart';
import 'package:event_radar2/feature/profile/presentation/screen/edit_profile.dart';
import 'package:event_radar2/feature/profile/presentation/screen/favourite_page.dart';
import 'package:event_radar2/feature/profile/presentation/screen/registered_page.dart';
import 'package:event_radar2/feature/profile/presentation/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  final bool isEo;
  const ProfilePage({super.key, required this.isEo});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String baseUrlImage = dotenv.env['BASE_URL']!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 32.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(
                            "$baseUrlImage${state.profile.profile}"),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.profile.fullname,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: const Color(0xFF4E4E55),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            state.profile.email,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF4E4E55)),
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) => GetIt
                                                  .instance<ProfileCubit>(),
                                            ),
                                            BlocProvider(
                                                create: (context) =>
                                                    GetIt.instance<
                                                        ProfileAvatarCubit>()),
                                            BlocProvider(
                                                create: (context) =>
                                                    GetIt.instance<
                                                        SaveProfileCubit>()),
                                          ],
                                          child: const EditProfile(),
                                        )));
                          },
                          child: Icon(
                            Icons.edit,
                            size: 25.w,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  widget.isEo == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Events',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.sp,
                                  color: const Color(0xFF4E4E55)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) =>
                                                      GetIt.instance<
                                                          FavouriteEventCubit>(),
                                                  child: FavouritePage(),
                                                )));
                                  },
                                  child: CustomLogoWidget(
                                      imagePath:
                                          'asset/img/profile/saved_icon.png',
                                      text: 'Saved'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => GetIt
                                                      .instance<ProfileCubit>(),
                                                  child: RegisteredPage(),
                                                )));
                                  },
                                  child: CustomLogoWidget(
                                      imagePath:
                                          'asset/img/profile/registered_icon.png',
                                      text: 'Registered'),
                                ),
                                const CustomLogoWidget(
                                    imagePath:
                                        'asset/img/profile/finished_icon.png',
                                    text: 'Finished'),
                                const CustomLogoWidget(
                                    imagePath:
                                        'asset/img/profile/certificate_icon.png',
                                    text: 'Certificate'),
                              ],
                            )
                          ],
                        )
                      : SizedBox.shrink()
                ],
              ),
            );
          }
          return const SizedBox.expand(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
