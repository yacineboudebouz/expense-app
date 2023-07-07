import 'package:expenseapp/models/database_provider.dart';
import 'package:expenseapp/widgets/expense_screen/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.expenses;
      return ListView.builder(
        itemBuilder: (context, index) => ExpenseCard(expense: list[index]),
        itemCount: list.length,
      );
    });
  }
}
