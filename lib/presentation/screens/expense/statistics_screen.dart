import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state_management/expense_summary_provider.dart';
import '../../widgets/expense_summary_widget.dart';

class StatistisScreen extends StatefulWidget {
  const StatistisScreen({super.key});

  @override
  State<StatistisScreen> createState() => _StatistisScreenState();
}

class _StatistisScreenState extends State<StatistisScreen> {
  @override
  void initState() {
    Provider.of<ExpenseSummaryProvider>(context, listen: false)
        .fetchDailySummary();
    Provider.of<ExpenseSummaryProvider>(context, listen: false)
        .fetchWeeklySummary();
    Provider.of<ExpenseSummaryProvider>(context, listen: false)
        .fetchMonthlySummary();
    super.initState();
  }

  Widget build(BuildContext context) {
    final summaryProvider =
        Provider.of<ExpenseSummaryProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 95,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Statistics",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ExpenseSummaryWIdget(
                  title: 'Day',
                  summaryAmount: summaryProvider.dailyTotal.toString(),
                ),
                ExpenseSummaryWIdget(
                  title: 'Week',
                  summaryAmount: summaryProvider.weeklyTotal.toString(),
                ),
                ExpenseSummaryWIdget(
                  title: 'Month',
                  summaryAmount: summaryProvider.monthlyTotal.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
