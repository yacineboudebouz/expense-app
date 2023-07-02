import 'package:flutter/material.dart';

import '../models/ex_category.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.title),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(category.icon),
      ),
      subtitle: Text('enetries: ${category.entries}'),
      trailing: Text('${(category.totalamount).toStringAsFixed(2)} DA'),
    );
  }
}
