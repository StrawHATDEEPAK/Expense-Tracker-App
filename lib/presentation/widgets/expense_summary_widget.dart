import 'package:flutter/material.dart';

class ExpenseSummaryWIdget extends StatelessWidget {
  final String title;
  String summaryAmount;
  ExpenseSummaryWIdget(
      {super.key, required this.title, required this.summaryAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey[300]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('₹', style: TextStyle(fontSize: 20)),
              Text(
                summaryAmount,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
