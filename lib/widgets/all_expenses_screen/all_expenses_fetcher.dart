import 'package:expenseapp/models/database_provider.dart';
import 'package:expenseapp/widgets/all_expenses_screen/all_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllExpensesFetcher extends StatefulWidget {
  const AllExpensesFetcher({
    super.key,
  });

  @override
  State<AllExpensesFetcher> createState() => _AllExpensesFetcherState();
}

class _AllExpensesFetcherState extends State<AllExpensesFetcher> {
  late Future _expensesList;

  Future _getExpensesList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expensesList = _getExpensesList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _expensesList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return AllExpensesList();
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
