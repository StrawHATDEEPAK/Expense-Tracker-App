import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_expense_tracker/core/utils/toast.dart';

import '../../core/entities/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      showToast(message: e.toString());
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      showToast(message: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<bool> addExpense(Expense expense) async {
    final user = auth.currentUser;

    if (user != null) {
      // Save the expense under the currently authenticated user's document
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .doc(expense.id.toString())
          .set(expense.toMap());

      return true;
    } else {
      showToast(message: 'User not logged in');
      return false;
    }
  }

  Future<void> syncExpenses(List<Expense> expenses) async {
    final user = auth.currentUser;

    if (user != null) {
      final batch = firestore.batch();
      for (var expense in expenses) {
        final docRef = firestore
            .collection('users')
            .doc(user.uid)
            .collection('expenses')
            .doc(expense.id.toString());
        batch.set(docRef, expense.toJson());
      }
      await batch.commit();
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<List<Expense>> getExpenses() async {
    final user = auth.currentUser;
    if (user != null) {
      final snapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .get();
      return snapshot.docs.map((doc) => Expense.fromMap(doc.data())).toList();
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .doc(expense.id.toString())
          .delete();
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .doc(expense.id.toString())
          .update(expense.toMap());
    } else {
      throw Exception('User not logged in');
    }
  }
}
