import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class EventDetailInputModel {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final categoryController = MultiSelectController<String>();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController maxParticipantsController =
      TextEditingController();
  String? selectedEventStatus;
  final TextEditingController linkController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  String? selectedEventType;
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DropdownItem<String>> items = [];

  bool get isEmpty {
    final bool basicFieldsEmpty = titleController.text.isEmpty ||
        dateController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty ||
        maxParticipantsController.text.isEmpty ||
        selectedEventType == null;

    if (basicFieldsEmpty) return true;

    // Additional validation based on event type
    if (selectedEventType == 'Online') {
      return linkController.text.isEmpty;
    } else if (selectedEventType == 'Offline') {
      return locationController.text.isEmpty;
    }

    return false;
  }
}
