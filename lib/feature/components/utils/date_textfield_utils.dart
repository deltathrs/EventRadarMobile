import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class BuildDatePickerTextFieldBox extends StatefulWidget {
  final String label;
  final bool isRequired;
  final String hint;
  final TextEditingController controller;
  final TextEditingController? time;
  final TextEditingController? location;

  final bool isEmpty;

  const BuildDatePickerTextFieldBox({
    super.key,
    required this.label,
    required this.hint,
    this.location,
    this.time,
    this.isRequired = false,
    required this.controller,
    this.isEmpty = false,
  });

  @override
  State<BuildDatePickerTextFieldBox> createState() =>
      _BuildDatePickerTextFieldBoxState();
}

class _BuildDatePickerTextFieldBoxState
    extends State<BuildDatePickerTextFieldBox> {
  final DateRangePickerController _controller = DateRangePickerController();
  String? previousValue; // To store the previous value

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    widget.controller.removeListener(_handleControllerChange);
  }

  @override
  Widget build(BuildContext context) {
    return inputBoxCalendar(
        widget.label, widget.hint, Icon(Icons.calendar_today));
  }

  Widget inputBoxCalendar(String label, String hint, Icon suffIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            children: widget.isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: true,
          onTap: () {
            showModalBottomSheet(
              isDismissible: false,
              context: context,
              isScrollControlled: true,
              builder: (context) => StatefulBuilder(builder: (context, state) {
                return _buildBottomForm(state, _controller);
              }),
            );
          },
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4E4E55),
          ),
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              Icons.calendar_month,
              color: Colors.grey,
            ),
            hintStyle: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF909090)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize with the current controller text
    previousValue = widget.controller.text;

    // Add a listener to detect changes
    widget.controller.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    if (widget.controller.text != previousValue) {
      // Check if the previous value was null or empty
      if (previousValue != null && previousValue!.isNotEmpty) {
        debugPrint(
            'Value changed from $previousValue to ${widget.controller.text}');

        // Only clear time and location when previousValue was not empty
        if (widget.time != null) {
          if (kDebugMode) {
            print('TIME PREVV');
          }
          widget.time!.text = '';
        }
      }

      // Update the previous value
      setState(() {
        previousValue = widget.controller.text;
      });
    }
  }

  Widget _buildBottomForm(
      StateSetter state, DateRangePickerController controller) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22)),
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  controller.selectedDate != null
                      ? DateFormat('d MMMM yyyy')
                          .format(controller.selectedDate!)
                      : "Select Date",
                  style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white),
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            controller: controller,
            backgroundColor: Colors.transparent,
            minDate: DateTime.now().add(Duration(days: 2)),
            enablePastDates: false,
            headerStyle:
                DateRangePickerHeaderStyle(backgroundColor: Colors.transparent),
            headerHeight: 50,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: GoogleFonts.inter(
                  fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            selectionColor: Color(0xFF1F24EA),
            onSelectionChanged: (args) {
              state(() {
                if (args.value is DateTime) {
                  debugPrint('Selected Date: ${controller.selectedDate}');
                }
              });
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 25),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.inter(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    state(() {
                      widget.controller.text = controller.selectedDate != null
                          ? DateFormat('yyyy-MM-dd')
                              .format(controller.selectedDate!)
                          : "";
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF1F24EA),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Apply",
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
