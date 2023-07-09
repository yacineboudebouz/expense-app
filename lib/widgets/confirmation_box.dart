import 'package:expenseapp/models/database_provider.dart';
import 'package:expenseapp/models/expense.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/icons.dart';

class ConfirmationBox extends StatelessWidget {
  const ConfirmationBox({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      title: Text('Delete ${expense.title} ?'),
      content: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Don\'t delete')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                provider.deleteExpense(
                    expense.id, expense.category, expense.amount);
              },
              child: const Text('Delete'))
        ],
      ),
    );
  }
}
