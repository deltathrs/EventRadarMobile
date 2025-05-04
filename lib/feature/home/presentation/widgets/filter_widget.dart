import 'package:choice/choice.dart';
import 'package:event_radar2/feature/components/utils/button_expanded_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  final List<String> categories;
  final Function(List<String> statusList, bool isOnline)? onFilterApplied;
  const FilterWidget(
      {Key? key, required this.categories, required this.onFilterApplied})
      : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> choices = [
    "Technology",
    "Business",
    "Health & Wellness",
    "Lifestyle",
    "Entertainment",
    "Music",
    "Sports",
    "Competition",
    "Artificial Intelligence",
    "Education",
    "Finance",
    "Cybersecurity",
    "Esports",
    "Gaming",
    "Blockchain",
    "Startup",
    "Cloud",
    "Art",
    "Culture",
    "Development",
    "Diversity",
    "Environment",
    "Green Technology",
    "Film",
  ];

  late List<String> categories;
  late bool isOnline;

  @override
  void initState() {
    super.initState();
    initialList();
  }

  void setMultipleSelected(List<String> value) {
    setState(() {
      categories = value;
    });
  }

  void initialList() {
    categories = List.of(widget.categories);
  }

  Widget _buildSelection(List<String> choices, List<String> multipleSelected,
      Function(List<String> value) onSelectionChanged) {
    return InlineChoice<String>(
      clearable: true,
      multiple: true,
      onChanged: onSelectionChanged,
      value: [...multipleSelected],
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: ChoiceChip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            selected: state.selected(choices[i]),
            onSelected: state.onSelected(choices[i]),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: state.selected(choices[i])
                      ? Color.fromARGB(255, 21, 112, 239)
                      : Colors.grey),
            ),
            backgroundColor: Colors.white,
            showCheckmark: true,
            selectedColor: Color.fromARGB(255, 224, 242, 254),
            checkmarkColor: Color.fromARGB(255, 21, 112, 239),
            label: Text(
              choices[i],
              style: GoogleFonts.inter(
                  color: state.selected(choices[i])
                      ? Color.fromARGB(255, 21, 112, 239)
                      : const Color.fromARGB(255, 64, 64, 64),
                  fontWeight: state.selected(choices[i])
                      ? FontWeight.w600
                      : FontWeight.w400),
            ),
          ),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 0,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 10,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        initialList();
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => StatefulBuilder(
                  builder: (context, state) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Filter",
                                    style: GoogleFonts.inter(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      _resetFilter(state);
                                    },
                                    child: Text("Reset Filter",
                                        style: GoogleFonts.inter(
                                            color: Colors.blue)),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("By Category",
                                        style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)),
                                    _buildSelection(choices, categories,
                                        setMultipleSelected),
                                    Text("By Location",
                                        style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)),
                                            
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: buildButtonExpanded("Cancel",
                                          color: Colors.white,
                                          fontColor:
                                              Color.fromARGB(255, 21, 112, 239),
                                          border: true, onPressed: () {
                                    initialList(); // Reset the local copy to the parent's value
                                    Navigator.pop(context);
                                  })),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: buildButtonExpanded("Apply Filter",
                                          onPressed: () {
                                    Navigator.pop(context, true);
                                  })),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )).then((value) {
          if (value != null && widget.onFilterApplied != null) {
            widget.onFilterApplied!(
                categories, isOnline); // Return the selected filters
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            border: Border.all(color: const Color(0xFF6E6E6E)),
            shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.filter_list,
              size: 20.w,
            ),
          ),
        ),
      ),
    );
  }

  void _resetFilter(StateSetter state) {
    return state(() {
      categories.clear();
    });
  }
}
