import 'package:expenseapp/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_list.dart';

class ExpenseFetcher extends StatefulWidget {
  const ExpenseFetcher({required this.category, super.key});
  final String category;

  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {
  late Future _expenseList;

  Future _getExpensesList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(widget.category);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expenseList = _getExpensesList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _expenseList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const ExpenseList();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
