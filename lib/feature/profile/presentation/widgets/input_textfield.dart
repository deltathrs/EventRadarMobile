import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final bool isReadOnly;
  final bool isPhoneNumber;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const InputTextfield({
    super.key,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.isReadOnly = false,
    this.isPhoneNumber = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

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
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          keyboardType: isPhoneNumber ? TextInputType.phone : keyboardType,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4E4E55),
          ),
          decoration: InputDecoration(
            filled: isReadOnly,
            fillColor: isReadOnly ? const Color(0xFFD9D9D9) : null,
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: isReadOnly ? const Color(0xFF4E4E55) : Colors.grey,
            ),
            prefixIcon: isPhoneNumber
                ? Padding(
                    padding: const EdgeInsets.only(left: 12, right: 6),
                    child: Text(
                      '+62',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: isPhoneNumber
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: isReadOnly
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(color: Color(0xFF909090)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: validator ??
              (isRequired
                  ? (value) =>
                      value == null || value.isEmpty ? 'Required' : null
                  : null),
        ),
      ],
    );
  }
}
