import 'package:expenseapp/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.categories;
      var total = db.calculateTotalExpenses();
      return Row(
        children: [
          Expanded(
            flex: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Total Expenses: ' + total.toStringAsFixed(2) + ' DA',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 8.0),
                ...list.map((e) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                          const SizedBox(width: 5),
                          Text(e.title),
                          const SizedBox(width: 5),
                          Text(
                              '${((e.totalamount / total) * 100).toStringAsFixed(2)}% ')
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 20,
                sections: list
                    .map((e) => PieChartSectionData(
                        showTitle: false,
                        value: e.totalamount,
                        color: Colors.primaries[list.indexOf(e)]))
                    .toList(),
              ),
            ),
          )
        ],
      );
    });
  }
}
