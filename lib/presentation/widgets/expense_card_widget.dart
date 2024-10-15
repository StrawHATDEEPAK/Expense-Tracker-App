import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/entities/expense.dart';
import 'package:personal_expense_tracker/core/utils/constant.dart';
import 'package:personal_expense_tracker/presentation/screens/expense/add_expense.dart';
import 'package:personal_expense_tracker/presentation/state_management/expense_provider.dart';
import 'package:provider/provider.dart';

import '../state_management/expense_summary_provider.dart';

class ExpenseCardWidget extends StatelessWidget {
  final Expense expense;
  const ExpenseCardWidget({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (dialogContext) => Dialog(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<ExpenseProvider>(context, listen: false)
                            .deleteExpense(expense);

                        Provider.of<ExpenseSummaryProvider>(context,
                                listen: false)
                            .fetchDailySummary();
                        Provider.of<ExpenseSummaryProvider>(context,
                                listen: false)
                            .fetchWeeklySummary();
                        Provider.of<ExpenseSummaryProvider>(context,
                                listen: false)
                            .fetchMonthlySummary();
                        Navigator.pop(dialogContext);
                      },
                      child: const ListTile(
                        title: Text('Delete Expense'),
                        leading: Icon(Icons.delete),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddExpenseScreen(
                                isUpdateExpense: true,
                                expense: expense,
                              ),
                            ));
                      },
                      child: const ListTile(
                        title: Text('Update Expense'),
                        leading: Icon(Icons.update),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 6,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 15, left: 15, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: categoryList
                                    .firstWhere((element) =>
                                        element.title == expense.title)
                                    .color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 6,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            child: Icon(
                              categoryList
                                  .firstWhere((element) =>
                                      element.title == expense.title)
                                  .icon,
                              size: 40,
                            ),
                          ),
                          Text(
                            '${expense.date}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expense.title,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(expense.description),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    expense.amount.toString(),
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
