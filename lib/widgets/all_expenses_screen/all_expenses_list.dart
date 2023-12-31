import 'package:expenseapp/widgets/expense_screen/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/database_provider.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.expenses;
      list.sort((a, b) => b.date.compareTo(a.date));
      return list.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: list.length,
              itemBuilder: (context, index) => ExpenseCard(
                expense: list[index],
              ),
            )
          : const Center(
              child: Text('No expenses'),
            );
    });
  }
}
