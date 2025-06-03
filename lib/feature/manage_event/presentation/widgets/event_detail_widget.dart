import 'package:event_radar2/feature/components/utils/date_textfield_utils.dart';
import 'package:event_radar2/feature/components/utils/input_dropdown_utils.dart';
import 'package:event_radar2/feature/components/utils/input_multiple_utils.dart';
import 'package:event_radar2/feature/components/utils/input_textfield_utils.dart';
import 'package:event_radar2/feature/components/utils/input_time_field_utils.dart';
import 'package:event_radar2/feature/manage_event/data/event_detail_input_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class EventDetailWidget extends StatefulWidget {
  final List<String> categories;
  EventDetailInputModel eventDetailInputModel;
  EventDetailWidget(
      {Key? key, required this.categories, required this.eventDetailInputModel})
      : super(key: key);

  @override
  EventDetailWidgetState createState() => EventDetailWidgetState();
}

class EventDetailWidgetState extends State<EventDetailWidget> {
  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController dateController = TextEditingController();
  // final categoryController = MultiSelectController<String>();
  // final TextEditingController locationController = TextEditingController();
  // final TextEditingController linkController = TextEditingController();

  // final TextEditingController startTimeController = TextEditingController();
  // final TextEditingController endTimeController = TextEditingController();

  // String? selectedEventType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // List<DropdownItem<String>> items = [];

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validateCategory(List<String>? values) {
    if (values == null || values.isEmpty) {
      return 'Please select at least one category';
    }
    return null;
  }

  bool validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (widget.eventDetailInputModel.selectedEventType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select event type')),
      );
      return false;
    }

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.eventDetailInputModel.items = widget.categories
        .map((category) => DropdownItem(label: category, value: category))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextfieldUtils(
              label: "Event Title",
              hint: "Input your event title",
              controller: widget.eventDetailInputModel.titleController,
              validator: (value) => _validateRequired(value, 'Event title'),
            ),
            SizedBox(
              height: 10,
            ),
            InputMultiDropdownUtils(
              label: 'Category',
              controller: widget.eventDetailInputModel.categoryController,
              isRequired: true,
              items: widget.eventDetailInputModel.items,
              validator: (value) =>
                  _validateCategory(value?.map((e) => e.value).toList()),
            ),
            SizedBox(
              height: 10,
            ),
            InputDropdownUtils(
              label: 'Event Type',
              hint: 'Online',
              isRequired: true,
              value: widget.eventDetailInputModel.selectedEventType,
              onChanged: (value) {
                setState(() {
                  widget.eventDetailInputModel.selectedEventType = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 'Online', child: Text('Online')),
                DropdownMenuItem(value: 'Offline', child: Text('Offline')),
              ],
              validator: (value) => _validateRequired(value, 'Event Type'),
            ),
            SizedBox(
              height: 10,
            ),
            BuildDatePickerTextFieldBox(
              label: 'Event Date',
              hint: 'Input event date',
              isRequired: true,
              controller: widget.eventDetailInputModel.dateController,
              validator: (value) => _validateRequired(value, 'Event Date'),
            ),
            SizedBox(
              height: 10,
            ),
            widget.eventDetailInputModel.selectedEventType == 'Offline'
                ? InputTextfieldUtils(
                    label: "Location",
                    hint: "Input your event location",
                    isRequired: true,
                    controller: widget.eventDetailInputModel.locationController,
                    validator: (value) =>
                        _validateRequired(value, 'Event Location'),
                  )
                : InputTextfieldUtils(
                    label: 'Link Meet',
                    isRequired: true,
                    hint: 'Input your link meet here',
                    controller: widget.eventDetailInputModel.linkController,
                    validator: (value) => _validateRequired(value, 'Link Meet'),
                  ),
            SizedBox(
              height: 10,
            ),
            InputTimeFieldUtils(
              label: "Start Time",
              eventDate:
                  widget.eventDetailInputModel.dateController.text.isNotEmpty
                      ? DateTime.parse(
                          widget.eventDetailInputModel.dateController.text)
                      : DateTime(0),
              controller: widget.eventDetailInputModel.startTimeController,
              isRequired: true,
              validator: (value) => _validateRequired(value, 'Start Time'),
            ),
            SizedBox(
              height: 10,
            ),
            InputTimeFieldUtils(
              label: "End Time",
              eventDate:
                  widget.eventDetailInputModel.dateController.text.isNotEmpty
                      ? DateTime.parse(
                          widget.eventDetailInputModel.dateController.text)
                      : DateTime(0),
              controller: widget.eventDetailInputModel.endTimeController,
              isRequired: true,
              validator: (value) => _validateRequired(value, 'End Time'),
            ),
          ],
        ),
      ),
    );
  }
}
