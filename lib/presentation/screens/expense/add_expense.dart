import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/utils/constant.dart';
import 'package:personal_expense_tracker/presentation/state_management/expense_provider.dart';
import 'package:personal_expense_tracker/presentation/widgets/auth_button_widget.dart';
import 'package:personal_expense_tracker/presentation/widgets/category_select_widget.dart';
import 'package:personal_expense_tracker/presentation/widgets/date_pick_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/entities/expense.dart';
import '../../state_management/expense_summary_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  final bool isUpdateExpense;
  Expense? expense;
  AddExpenseScreen({super.key, required this.isUpdateExpense, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final amountTextController = TextEditingController();
  final descTextController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateExpense) {
      amountTextController.text = widget.expense!.amount.toString();
      descTextController.text = widget.expense!.description.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    amountTextController.dispose();
    descTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text('Expenses',
                  style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Center(
                child: SizedBox(
                  child: TextField(
                    controller: amountTextController,
                    showCursor: false,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 70),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '0.0',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 70),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Description',
                  style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descTextController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200]!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Category',
                  style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  for (var i in categoryList)
                    CategorySelectWidgetContainer(
                      index: categoryList.indexOf(i),
                      item: i,
                    )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Date',
                  style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              DatePickWidget(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              AuthButtonWidget(
                  onTap: () {
                    if (!widget.isUpdateExpense) {
                      provider.addExpense(Expense(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: categoryList[provider.selectedCategory].title,
                        amount: double.parse(amountTextController.text),
                        date: provider.selectedDate,
                        description: descTextController.text,
                      ));
                    } else {
                      Expense updatedExpense = Expense(
                        id: widget.expense!.id,
                        title: categoryList[provider.selectedCategory].title,
                        amount: double.parse(amountTextController.text),
                        date: provider.selectedDate,
                        description: descTextController.text,
                      );

                      provider.updateExpense(updatedExpense);
                    }
                    provider.fetchExpenses();
                    Provider.of<ExpenseSummaryProvider>(context, listen: false)
                        .fetchDailySummary();
                    Provider.of<ExpenseSummaryProvider>(context, listen: false)
                        .fetchWeeklySummary();
                    Provider.of<ExpenseSummaryProvider>(context, listen: false)
                        .fetchMonthlySummary();
                    Navigator.pop(context);
                  },
                  title: 'Add Expense'),
            ],
          ),
        ),
      ),
    );
  }
}
