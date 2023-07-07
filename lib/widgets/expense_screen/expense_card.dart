import 'package:expenseapp/models/expense.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/icons.dart';

class ExpenseCard extends StatelessWidget {
  Expense expense;
  ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icons[expense.category]),
      ),
      title: Text(expense.title),
      subtitle: Text(DateFormat('MMMM dd, yyyy').format(expense.date)),
      trailing: Text('${(expense.amount).toStringAsFixed(2)} DA'),
    );
  }
}
