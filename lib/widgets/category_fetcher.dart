import 'package:expenseapp/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_list.dart';

class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {
  late Future _categoryList;

  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryList = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _categoryList,
        builder: (_, snapshots) {
          if (snapshots.connectionState == ConnectionState.done) {
            if (snapshots.hasError) {
              return Center(
                child: Text(snapshots.error.toString()),
              );
            } else {
              return const CategoryList();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
