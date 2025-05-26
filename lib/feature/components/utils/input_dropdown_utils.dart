import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputDropdownUtils<T> extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool isReadOnly;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const InputDropdownUtils({
    super.key,
    required this.label,
    this.isRequired = false,
    this.isReadOnly = false,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
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
                      style: const TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 6),
        IgnorePointer(
          ignoring: isReadOnly,
          child: Material(
            elevation: 1,
            child: DropdownButtonFormField<T>(
              value: value,
              onChanged: onChanged,
              items: items,
              validator: validator ??
                  (isRequired
                      ? (value) => value == null ? 'Required' : null
                      : null),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: isReadOnly
                      ? const BorderSide(color: Colors.transparent)
                      : const BorderSide(color: Color(0xFF909090)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }
}
