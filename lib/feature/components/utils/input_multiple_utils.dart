import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputMultiDropdownUtils extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool enabled;
  final MultiSelectController<String> controller;
  final List<DropdownItem<String>> items;
  final String? Function(List<DropdownItem<String>>?)? validator;
  final void Function(List<String>)? onSelectionChange;

  const InputMultiDropdownUtils({
    Key? key,
    required this.label,
    required this.controller,
    required this.items,
    this.enabled = true,
    this.isRequired = false,
    this.onSelectionChange,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            children: isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        SizedBox(height: 6.h),
        MultiDropdown<String>(
          items: items,
          controller: controller,
          enabled: enabled,
          chipDecoration: ChipDecoration(
            backgroundColor: Color(0xFF231FEA),
            wrap: true,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            deleteIcon: Icon(
              Icons.close,
              color: Colors.white,
              size: 12.w,
            ),
            runSpacing: 2,
            spacing: 10,
          ),
          fieldDecoration: FieldDecoration(
            hintText: 'Select $label',
            hintStyle: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
            showClearIcon: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Colors.black87,
              ),
            ),
          ),
          dropdownDecoration: DropdownDecoration(
            marginTop: 2,
            header: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Select category from the list',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          dropdownItemDecoration: DropdownItemDecoration(
            selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
            disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
          ),
          validator: validator,
          onSelectionChange: (selectedItems) {
            debugPrint("OnSelectionChange: $selectedItems");
          },
        ),
      ],
    );
  }
}
