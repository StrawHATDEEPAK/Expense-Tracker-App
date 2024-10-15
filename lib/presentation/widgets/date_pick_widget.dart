import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/expense_provider.dart';

class DatePickWidget extends StatelessWidget {
  DatePickWidget({super.key});

  DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String selectedDate =
        Provider.of<ExpenseProvider>(context, listen: true).selectedDate;
    return GestureDetector(
      onTap: () async {
        date = await showDatePicker(
            context: context,
            firstDate: DateTime(2024),
            lastDate: DateTime(2026));

        if (date != null) {
          if (context.mounted) {
            Provider.of<ExpenseProvider>(context, listen: false)
                .selectDate(date.toString().substring(0, 10));
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            selectedDate,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
