import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/handle_content_event/handle_content_event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/content_visual_widget.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/event_detail_widget.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/manage_event_form_button_widget.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/manage_event_step_indicator_widget.dart';
import 'package:event_radar2/feature/manage_event/presentation/widgets/ticket_setup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageEventPage extends StatefulWidget {
  const ManageEventPage({Key? key}) : super(key: key);

  @override
  _ManageEventPageState createState() => _ManageEventPageState();
}

class _ManageEventPageState extends State<ManageEventPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HandleContentEventCubit _handleContentEventCubit =
      HandleContentEventCubit();
  final ManageEventCubit _cubit =
      GetIt.instance<ManageEventCubit>(); // Initialize the ManageEventCubit
  late PageController _pageController;
  List<String> items = [];
  bool initializeAllPage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    init();
  }

  void init() async {
    await _cubit.getEventCategory();
    await Future.delayed(Duration(milliseconds: 500));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _pageController.animateToPage(0,
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      await _pageController.animateToPage(1,
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      await _pageController.animateToPage(2,
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      await _pageController.animateToPage(0,
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);

      initializeAllPage = false;
      debugPrint("initializeAllPage: $initializeAllPage");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlocConsumer<ManageEventCubit, ManageEventState>(
        bloc: _cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ManageEventLoaded) {
            items = state.categories.map((e) => e).toList();
          } else if (state is ManageEventLoading) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Container(
                  color: Colors.white,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: const Color.fromARGB(255, 33, 58, 243),
                  ))),
            );
          } else if (state is ManageEventError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              BottomSheetUtils.displayResultBottomSheet(
                  context: context,
                  title: "Failed to load Goods Receive",
                  description: state.message,
                  image: 'asset/img/event/failed.jpg',
                  completion: 'Back',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
            });
            return Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 15, 18, 47),
                )));
          }
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              title: Text(
                'Create Event',
                style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ManageEventStepIndicatorWidget(
                          cubit: _handleContentEventCubit),
                      BlocListener<HandleContentEventCubit,
                          HandleContentEventState>(
                        bloc: _handleContentEventCubit,
                        listener: (context, state) {
                          if (state is HandleContentEventPageUpdated) {
                            _pageController.animateToPage(state.pageIndex,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Expanded(
                            child: PageView.builder(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return EventDetailWidget(
                                        categories: items,
                                      );
                                    case 1:
                                      return ContentVisualWidget();
                                    case 2:
                                      return TicketSetupWidget();
                                  }
                                })),
                      ),
                      ManageEventFormButtonWidget(
                        cubit: _handleContentEventCubit,
                        manageEventCubit: _cubit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
