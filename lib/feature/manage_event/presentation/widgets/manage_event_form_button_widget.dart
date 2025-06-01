import 'package:event_radar2/feature/manage_event/presentation/cubits/handle_content_event/handle_content_event_cubit.dart';
import 'package:event_radar2/feature/manage_event/presentation/cubits/manage_event/manage_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageEventFormButtonWidget extends StatefulWidget {
  final HandleContentEventCubit cubit;
  final ManageEventCubit manageEventCubit;
  const ManageEventFormButtonWidget(
      {Key? key, required this.cubit, required this.manageEventCubit})
      : super(key: key);

  @override
  _ManageEventFormButtonWidgetState createState() =>
      _ManageEventFormButtonWidgetState();
}

class _ManageEventFormButtonWidgetState
    extends State<ManageEventFormButtonWidget> {
  int pageIndex = 0;
  bool isAtBottom = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageEventCubit, ManageEventState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          child: BlocListener<HandleContentEventCubit, HandleContentEventState>(
            bloc: widget.cubit,
            listener: (context, state) {
              if (state is HandleContentEventPageUpdated) {
                setState(() {
                  pageIndex = state.pageIndex;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: isAtBottom
                    ? [] // No shadow when at the bottom
                    : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, -2), // changes position of shadow
                        ),
                      ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewPadding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).viewPadding.bottom,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: pageIndex != 0
                                ? () {
                                    setState(() {
                                      widget.cubit.previousPage();
                                    });
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFD0D5DD),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Previous",
                                  style: GoogleFonts.inter(
                                    color: Color.fromARGB(255, 21, 112, 239),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                widget.cubit.nextPage();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    pageIndex == 2 ? Colors.blue : Colors.white,
                                border: pageIndex == 2
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(
                                        color: Colors.blue,
                                        width: 0.5,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isLoading == false
                                  ? Text(
                                      pageIndex == 2 ? "Submit" : "Next",
                                      style: GoogleFonts.inter(
                                        color: pageIndex == 2
                                            ? Colors.white
                                            : Color.fromARGB(255, 21, 112, 239),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: widget.isCreateNew ? 0 : 10),
                    // Container()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
