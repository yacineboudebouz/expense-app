import 'package:expenseapp/models/database_provider.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/confirmation_box.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/icons.dart';

class ExpenseCard extends StatelessWidget {
  Expense expense;
  ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Dismissible(
      confirmDismiss: (_) async {
        showDialog(
            context: context,
            builder: (_) => ConfirmationBox(expense: expense));
      },
      key: ValueKey(expense.id),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icons[expense.category]),
        ),
        title: Text(expense.title),
        subtitle: Text(DateFormat('MMMM dd, yyyy').format(expense.date)),
        trailing: Text('${(expense.amount).toStringAsFixed(2)} DA'),
      ),
    );
  }
}
