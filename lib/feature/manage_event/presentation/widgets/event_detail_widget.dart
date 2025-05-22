import 'package:event_radar2/feature/components/utils/input_textfield_utils.dart';
import 'package:flutter/material.dart';

class EventDetailWidget extends StatefulWidget {
  const EventDetailWidget({Key? key}) : super(key: key);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputTextfieldUtils(
              label: "Event Title",
              hint: "Input your event title",
              controller: titleController),
          SizedBox(
            height: 10,
          ),
          // InputTextfieldUtils(label: "", hint: hint, controller: controller)
        ],
      ),
    );
  }
}
