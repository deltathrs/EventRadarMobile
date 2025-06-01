import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTimeFieldUtils extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool isReadOnly;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const InputTimeFieldUtils({
    super.key,
    required this.label,
    this.isRequired = false,
    this.isReadOnly = false,
    required this.controller,
    this.validator,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = picked.format(context);
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isReadOnly ? null : () => _selectTime(context),
      child: AbsorbPointer(
        absorbing: true,
        child: Column(
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
              readOnly: true,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4E4E55),
              ),
              decoration: InputDecoration(
                filled: isReadOnly,
                fillColor: isReadOnly ? const Color(0xFFD9D9D9) : null,
                hintText: 'Select Time',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: isReadOnly ? const Color(0xFF4E4E55) : Colors.grey,
                ),
                suffixIcon: const Icon(Icons.access_time),
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
        ),
      ),
    );
  }
}
