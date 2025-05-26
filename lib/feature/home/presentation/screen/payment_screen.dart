import 'package:event_radar2/feature/components/utils/bottom_sheet_utils.dart';
import 'package:event_radar2/feature/components/utils/url_launcher_utils.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final String ticketId;
  const PaymentScreen({Key? key, required this.url, required this.ticketId})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UrlLauncherUtils.launchURL(actionType: 'browser', value: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment',
            style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        body: BlocListener<EventDetailCubit, EventDetailState>(
          listener: (context, state) {
            if (state is EventDetailBuyLoading) {
              BottomSheetUtils.showLoadingDialog(context);
            }

            if (state is EventDetailBuySuccess) {
              Navigator.pop(context);
              if (state.message.contains('Payment completed successfully')) {
                BottomSheetUtils.displayResultBottomSheet(
                    title: "Payment Success",
                    description:
                        "Congratulations you have finished your transaction",
                    image: "asset/img/event/success.jpg",
                    completion: "Go To Event List",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    context: context);
              } else {
                BottomSheetUtils.displayResultBottomSheet(
                    title: "Payment Failed",
                    description: "",
                    image: "asset/img/event/failed.jpg",
                    completion: "Try Again",
                    onTap: () {
                      Navigator.pop(context);
                      UrlLauncherUtils.launchURL(
                          actionType: 'browser', value: widget.url);
                    },
                    context: context);
              }
            }

            if (state is EventDetailBuyFailed) {
              Navigator.pop(context);
              BottomSheetUtils.displayResultBottomSheet(
                  title: "Payment Failed",
                  description: state.message,
                  image: "asset/img/event/failed.jpg",
                  completion: "Try Again",
                  onTap: () {
                    Navigator.pop(context);
                    UrlLauncherUtils.launchURL(
                        actionType: 'browser', value: widget.url);
                  },
                  context: context);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('asset/img/event/waiting_icon.json',
                  alignment: Alignment.center),
              GestureDetector(
                onTap: () {
                  context.read<EventDetailCubit>().buyEvent(widget.ticketId);
                },
                child: Container(
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Color(0xFF231EAF),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Center(
                      child: Text(
                        'Check Payment Status',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
