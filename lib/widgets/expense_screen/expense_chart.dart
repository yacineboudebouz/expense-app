import 'package:expenseapp/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({required this.category, super.key});
  final String category;

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, db, child) {
        var maxY = db.calculateEntriesAndAmount(widget.category)['totalAmount'];
        var list = db.calculateWeekExpenses().reversed.toList();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: BarChart(BarChartData(minY: 0, maxY: maxY, barGroups: [
            ...list.map((e) => BarChartGroupData(x: list.indexOf(e), barRods: [
                  BarChartRodData(
                      toY: e['amount'],
                      width: 20.0,
                      borderRadius: BorderRadius.zero,
                      color: Colors.primaries[list.indexOf(e)])
                ]))
          ])),
        );
      },
    );
  }
}
