import 'package:event_radar2/feature/components/utils/input_multiple_utils.dart';
import 'package:event_radar2/feature/components/utils/input_textfield_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class EventDetailWidget extends StatefulWidget {
  final List<String> categories;
  const EventDetailWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  final TextEditingController titleController = TextEditingController();
  final categoryController = MultiSelectController<String>();
  List<DropdownItem<String>> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.categories
        .map((category) => DropdownItem(label: category, value: category))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // var items = [
    //   DropdownItem(label: 'Nepal', value: 'Nepal'),
    //   DropdownItem(label: 'Australia', value: User(name: 'Australia', id: 6)),
    //   DropdownItem(label: 'India', value: User(name: 'India', id: 2)),
    //   DropdownItem(label: 'China', value: User(name: 'China', id: 3)),
    //   DropdownItem(label: 'USA', value: User(name: 'USA', id: 4)),
    //   DropdownItem(label: 'UK', value: User(name: 'UK', id: 5)),
    //   DropdownItem(label: 'Germany', value: User(name: 'Germany', id: 7)),
    //   DropdownItem(label: 'France', value: User(name: 'France', id: 8)),
    // ];

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
          InputMultiDropdownUtils(
            label: 'Category',
            controller: categoryController,
            items: items,
          ),

          // MultiDropdown<String>(
          //   items: items,
          //   controller: categoryController,
          //   enabled: true,
          //   chipDecoration: const ChipDecoration(
          //     backgroundColor: Colors.yellow,
          //     wrap: true,
          //     runSpacing: 2,
          //     spacing: 10,
          //   ),
          //   fieldDecoration: FieldDecoration(
          //     labelText: 'Category',
          //     hintText: 'Category',
          //     hintStyle: const TextStyle(color: Colors.black87),
          //     prefixIcon: const Icon(CupertinoIcons.flag),
          //     showClearIcon: false,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: const BorderSide(color: Colors.grey),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: const BorderSide(
          //         color: Colors.black87,
          //       ),
          //     ),
          //   ),
          //   dropdownDecoration: const DropdownDecoration(
          //     marginTop: 2,
          //     // maxHeight: 500,
          //     header: Padding(
          //       padding: EdgeInsets.all(8),
          //       child: Text(
          //         'Select category from the list',
          //         textAlign: TextAlign.start,
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          //   dropdownItemDecoration: DropdownItemDecoration(
          //     selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
          //     disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please select a category';
          //     }
          //     return null;
          //   },
          //   onSelectionChange: (selectedItems) {
          //     debugPrint("OnSelectionChange: $selectedItems");
          //   },
          // ),

          // InputTextfieldUtils(label: "", hint: hint, controller: controller)
        ],
      ),
    );
  }
}
