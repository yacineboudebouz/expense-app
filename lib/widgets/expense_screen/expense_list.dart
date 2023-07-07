import 'package:expenseapp/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.expenses;
      return ListView.builder(
        itemBuilder: (context, index) => Text(list[index].title),
        itemCount: list.length,
      );
    });
  }
}
