import 'package:flutter/material.dart';

class MarkdownInputUtilField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged; // Callback when text changes
  final InputDecoration? decoration;
  final int? minLines;
  final int? maxLines;
  final TextStyle? style;

  const MarkdownInputUtilField({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.decoration,
    this.minLines,
    this.maxLines = 5,
    this.style,
  });

  @override
  State<MarkdownInputUtilField> createState() => _MarkdownInputUtilFieldState();
}

class _MarkdownInputUtilFieldState extends State<MarkdownInputUtilField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void didUpdateWidget(covariant MarkdownInputUtilField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the initialValue changes externally, update the controller
    // This is useful if the parent widget can reset or change the content
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      // Only update if different to avoid potential cursor jumps if typing
      _controller.text = widget.initialValue ?? '';
      // Move cursor to end after programmatic text change
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a default decoration if none is provided
    final defaultDecoration = InputDecoration(
      hintText: 'Enter Markdown (e.g., # Title, **bold**)',
      border: const OutlineInputBorder(),
      helperText: 'Supports Markdown syntax.',
      alignLabelWithHint: true, // Good for multiline fields
    );

    return TextField(
      controller: _controller,
      decoration: widget.decoration ?? defaultDecoration,
      style: widget.style,
      keyboardType: TextInputType.multiline,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textAlignVertical: TextAlignVertical.top, // Aligns text to the top
    );
  }
}
