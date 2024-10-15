import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/utils/providers_list.dart';
import 'package:personal_expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:personal_expense_tracker/presentation/screens/expense/expense_screen.dart';
import 'package:provider/provider.dart';

import 'data/db/expense_db.dart';
import 'presentation/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final expenseDb = ExpenseDB();

  await NotificationService().init();
  await expenseDb.database;

  runApp(
    MultiProvider(
      providers: providersList(expenseDb: expenseDb),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[200]!),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const ExpenseScreen()
          : const LoginScreen(),
    );
  }
}
