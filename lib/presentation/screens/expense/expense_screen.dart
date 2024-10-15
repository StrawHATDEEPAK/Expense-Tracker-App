import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:personal_expense_tracker/presentation/screens/expense/add_expense.dart';
import 'package:personal_expense_tracker/presentation/screens/expense/statistics_screen.dart';
import 'package:personal_expense_tracker/presentation/state_management/expense_summary_provider.dart';
import 'package:personal_expense_tracker/presentation/state_management/user_provider.dart';
import 'package:personal_expense_tracker/presentation/widgets/expense_summary_widget.dart';
import 'package:personal_expense_tracker/presentation/widgets/grey_rounded_container.dart';
import 'package:provider/provider.dart';

import '../../state_management/expense_provider.dart';
import '../../widgets/expense_card_widget.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpenseScreen(
                    isUpdateExpense: false,
                  ),
                ));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GreyRoundedContainer(
                      icon: Icons.trending_up_outlined,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StatistisScreen(),
                            ));
                      }),
                  GreyRoundedContainer(
                      icon: Icons.logout,
                      onTap: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .logout()
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                )));
                      }),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 95,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Expenses",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.white,
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'item1',
                          child: Text('Sort by Date'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'item2',
                          child: Text('Sort by Amount'),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == 'item1') {
                          Provider.of<ExpenseProvider>(context, listen: false)
                              .sortByDate();
                        } else if (value == 'item2') {
                          Provider.of<ExpenseProvider>(context, listen: false)
                              .sortByAmount();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Consumer<ExpenseProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (value.expenses.isEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_to_photos_rounded,
                          size: 80,
                          color: Colors.grey[700],
                        ),
                        const Text(
                          'Add expenses',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: value.expenses.length,
                      itemBuilder: (context, index) {
                        return ExpenseCardWidget(
                            expense: value.expenses[index]);
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
