import 'package:easy_stepper/easy_stepper.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/handle_content_event/handle_content_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageEventStepIndicatorWidget extends StatefulWidget {
  final HandleContentEventCubit cubit;
  const ManageEventStepIndicatorWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ManageEventStepIndicatorWidgetState createState() =>
      _ManageEventStepIndicatorWidgetState();
}

class _ManageEventStepIndicatorWidgetState
    extends State<ManageEventStepIndicatorWidget> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<HandleContentEventCubit, HandleContentEventState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is HandleContentEventPageUpdated) {
          setState(() {
            pageIndex = state.pageIndex;
          });
        }
      },
      child: EasyStepper(
        enableStepTapping: false,
        activeStep: pageIndex,
        lineStyle: LineStyle(
          lineLength: 20.w,
          lineType: LineType.normal,
          lineThickness: 3,
          lineSpace: 1,
          lineWidth: 10,
          unreachedLineType: LineType.normal,
          finishedLineColor: Color.fromARGB(255, 21, 112, 239),
          unreachedLineColor: Colors.grey,
          activeLineColor: Color.fromARGB(255, 21, 112, 239),
        ),
        // enableStepTapping: false,
        // dashPattern: [5, 4],
        internalPadding: 35,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        stepShape: StepShape.rRectangle,
        stepBorderRadius: 5,
        borderThickness: 4,
        stepRadius: 25,
        unreachedStepIconColor: Colors.grey,
        unreachedStepBorderType: BorderType.normal,
        activeStepBorderColor: Color.fromARGB(255, 21, 112, 239),
        finishedStepIconColor: Color.fromARGB(255, 21, 112, 239),
        finishedStepBackgroundColor: Colors.transparent,
        finishedStepBorderColor: Color.fromARGB(255, 21, 112, 239),
        finishedStepBorderType: BorderType.normal,
        activeStepIconColor: Colors.deepOrange,
        showLoadingAnimation: false,
        stepAnimationDuration: Duration(milliseconds: 300),
        stepAnimationCurve: Curves.easeInOut,
        steps: [
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: pageIndex >= 0 ? 1 : 0.3,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                    "asset/img/event_organizer/event_detail_icon.png",
                    width: 20.w,
                    height: 20.h,
                    color: pageIndex >= 0
                        ? Color.fromARGB(255, 21, 112, 239)
                        : Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            customTitle: Text(
              'Event Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: pageIndex >= 0
                      ? Color.fromARGB(255, 21, 112, 239)
                      : Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: pageIndex >= 1 ? 1 : 0.3,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                      "asset/img/event_organizer/content_visual_icon.png",
                      width: 20.w,
                      height: 20.h,
                      color: pageIndex >= 1
                          ? Color.fromARGB(255, 21, 112, 239)
                          : Colors.grey),
                  onPressed: () {},
                ),
              ),
            ),
            customTitle: Text(
              'Content & Visual',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: pageIndex >= 1
                      ? Color.fromARGB(255, 21, 112, 239)
                      : Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: pageIndex >= 2 ? 1 : 0.3,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                      "asset/img/event_organizer/content_visual_icon.png",
                      width: 20.w,
                      height: 20.h,
                      color: pageIndex >= 2
                          ? Color.fromARGB(255, 21, 112, 239)
                          : Colors.grey),
                  onPressed: () {},
                ),
              ),
            ),
            customTitle: Text(
              'Description',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: pageIndex >= 2
                      ? Color.fromARGB(255, 21, 112, 239)
                      : Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: pageIndex >= 3 ? 1 : 0.3,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                    "asset/img/event_organizer/ticket_icon.png",
                    width: 20.w,
                    height: 20.h,
                    color: pageIndex >= 3
                        ? Color.fromARGB(255, 21, 112, 239)
                        : Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            customTitle: Text(
              'Ticket Setup',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: pageIndex >= 3
                      ? Color.fromARGB(255, 21, 112, 239)
                      : Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
        onStepReached: (index) => setState(() => pageIndex = index),
      ),
    );
  }
}
