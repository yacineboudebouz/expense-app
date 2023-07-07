import 'package:expenseapp/widgets/expense_form.dart';
import 'package:flutter/material.dart';

import '../widgets/category_screen/category_fetcher.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Screen'),
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => const ExpenseForm(),
              isScrollControlled: true,
            );
          }),
    );
  }
}
