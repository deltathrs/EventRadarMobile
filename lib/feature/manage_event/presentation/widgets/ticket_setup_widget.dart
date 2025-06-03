import 'package:event_radar2/feature/components/utils/date_textfield_utils.dart';
import 'package:event_radar2/feature/components/utils/input_textfield_utils.dart';
import 'package:event_radar2/feature/manage_event/data/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketSetupWidget extends StatefulWidget {
  final void Function(List<TicketInputModel>) onTicketListChanged;
  const TicketSetupWidget({Key? key, required this.onTicketListChanged})
      : super(key: key);

  @override
  TicketSetupWidgetState createState() => TicketSetupWidgetState();
}

class TicketSetupWidgetState extends State<TicketSetupWidget> {
  List<TicketInputModel> tickets = [
    TicketInputModel(),
  ];

  bool validateAllForms() {
    bool isValid = true;
    for (var ticket in tickets) {
      if (!(ticket.formKey.currentState?.validate() ?? false)) {
        isValid = false;
      }
    }
    return isValid;
  }

  void _addTicket() {
    setState(() {
      tickets.add(TicketInputModel());
    });
    widget.onTicketListChanged(tickets);
  }

  void _removeTicket(int index) {
    setState(() {
      tickets.removeAt(index);
    });
    widget.onTicketListChanged(tickets);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onTicketListChanged(tickets);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: tickets.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Form(
                  key: ticket.formKey,
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ticket ${index + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp)),
                          SizedBox(height: 10),
                          InputTextfieldUtils(
                            label: 'Ticket Name',
                            hint: 'Input ticket name',
                            controller: ticket.nameController,
                            validator: (val) => val == null || val.isEmpty
                                ? 'Ticket name is required'
                                : null,
                          ),
                          SizedBox(height: 10),
                          InputTextfieldUtils(
                            label: 'Ticket Description',
                            hint: 'Input ticket description',
                            controller: ticket.descriptionController,
                            validator: (val) => val == null || val.isEmpty
                                ? 'Ticket description is required'
                                : null,
                          ),
                          SizedBox(height: 10),
                          InputTextfieldUtils(
                            label: 'Ticket Price',
                            hint: 'Input ticket price',
                            isPriceFormat: true,
                            controller: ticket.priceController,
                            validator: (val) => val == null || val.isEmpty
                                ? 'Ticket price is required'
                                : null,
                          ),
                          SizedBox(height: 10),
                          InputTextfieldUtils(
                            label: 'Ticket Quantity',
                            hint: 'Input ticket quantity',
                            controller: ticket.quantityController,
                            validator: (val) => val == null || val.isEmpty
                                ? 'Ticket quantity is required'
                                : null,
                          ),
                          SizedBox(height: 10),
                          BuildDatePickerTextFieldBox(
                            label: 'Registration Deadline',
                            hint: 'Choose date',
                            controller: ticket.dateController,
                            validator: (val) => val == null || val.isEmpty
                                ? 'Registration deadline is required'
                                : null,
                          ),
                          if (tickets.length > 1)
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => _removeTicket(index),
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          ElevatedButton.icon(
            onPressed: _addTicket,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF231EAF))),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Add Another Ticket',
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
