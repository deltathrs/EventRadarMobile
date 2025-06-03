import 'dart:io';

import 'package:event_radar2/feature/components/utils/image_input_utils.dart';
import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:flutter/material.dart';

class ContentVisualWidget extends StatefulWidget {
  ContentVisualInputModel contentVisualInputModel;
  ContentVisualWidget({Key? key, required this.contentVisualInputModel})
      : super(key: key);

  @override
  ContentVisualWidgetState createState() => ContentVisualWidgetState();
}

class ContentVisualWidgetState extends State<ContentVisualWidget> {
  bool validateForm() {
    if (widget.contentVisualInputModel.userImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
      return false;
    }
    return true;
  }

  void _handleImageSelection(File? image) {
    setState(() {
      widget.contentVisualInputModel.userImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageInputField(
                  onImageSelected: _handleImageSelection,
                  selectedImage: widget.contentVisualInputModel.userImage),
            ],
          ),
        ),
      ),
    );
  }
}
