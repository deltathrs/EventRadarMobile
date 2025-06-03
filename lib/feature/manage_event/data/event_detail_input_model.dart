import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class EventDetailInputModel {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final categoryController = MultiSelectController<String>();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

   String? selectedEventType;
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DropdownItem<String>> items = [];
}
