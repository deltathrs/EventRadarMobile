import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionWidget extends StatefulWidget {
  ContentVisualInputModel contentVisualInputModel;
  DescriptionWidget({Key? key, required this.contentVisualInputModel})
      : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          QuillSimpleToolbar(
            controller: widget.contentVisualInputModel.controller,
            configurations: const QuillSimpleToolbarConfigurations(
              showBoldButton: true,
              showItalicButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showHeaderStyle: true,
              showListBullets: true,
              showListNumbers: true,
              showListCheck: false,
              showCodeBlock: false,
              showQuote: false,
              showIndent: false,
              showLink: false,
              showSearchButton: false,
              showInlineCode: false,
              showFontFamily: false,
              showFontSize: false,
            ),
          ),
          const Divider(height: 1),
          QuillEditor.basic(
            controller: widget.contentVisualInputModel.controller,
            configurations: QuillEditorConfigurations(
              showCursor: true,
              placeholder: 'Enter description here...',
              customStyles: DefaultStyles(
                paragraph: DefaultTextBlockStyle(
                    TextStyle(fontSize: 18.sp, color: Colors.black),
                    HorizontalSpacing(10, 10),
                    VerticalSpacing(10, 10),
                    VerticalSpacing(10, 10),
                    BoxDecoration()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
