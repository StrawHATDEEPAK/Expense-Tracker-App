import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/presentation/widgets/category_element.dart';

List<CategoryElement> categoryList = [
  CategoryElement(
      title: 'Shopping',
      icon: Icons.shopping_cart_sharp,
      color: Colors.green[300]!),
  CategoryElement(
      title: 'Food', icon: Icons.fastfood, color: Colors.yellow[300]!),
  CategoryElement(
      title: 'Travel', icon: Icons.flight, color: Colors.orange[300]!),
  CategoryElement(
      title: 'Entertainment', icon: Icons.movie, color: Colors.red[300]!),
  CategoryElement(
      title: 'Health', icon: Icons.health_and_safety, color: Colors.blue[300]!),
  CategoryElement(
      title: 'Other', icon: Icons.more_horiz, color: Colors.grey[300]!),
];
