import 'package:expenseapp/constants/icons.dart';
import 'package:flutter/material.dart';

class ExpenseCategory {
  final String title;
  int entries = 0;
  double totalamount = 0.0;
  final IconData icon;

  ExpenseCategory({
    required this.title,
    required this.entries,
    required this.totalamount,
    required this.icon,
  });
  // this to convert our model to a map to store it in the database
  Map<String, dynamic> toMap() => {
        'title': title,
        'entries': entries,
        'totalamount': totalamount.toString()
      };
  // then to bring back the date we need to re-convert it again
  factory ExpenseCategory.fromString(Map<String, dynamic> value) =>
      ExpenseCategory(
        title: value['title'],
        entries: value['entries'],
        totalamount: value['totalamount'],
        icon: icons[value['title']]!,
      );
}
