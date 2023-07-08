import 'package:expenseapp/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchExpense extends StatefulWidget {
  const SearchExpense({super.key});

  @override
  State<SearchExpense> createState() => _SearchExpenseState();
}

class _SearchExpenseState extends State<SearchExpense> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return TextField(
      onChanged: (value) {
        provider.searchText = value;
      },
      decoration: const InputDecoration(label: Text('Search Expenses')),
    );
  }
}
