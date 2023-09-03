import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tracely/backend/functions/limit_string.dart';

import '../../../../backend/functions/convert_currencies.dart';
import '../../../../backend/handlers/users/account_handler.dart';
import '../../../config/messages.dart';

class ExpensesChart extends StatelessWidget {
  const ExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    return StreamBuilder(
      stream: database
          .child("users/${getUID()}/expenses")
          .onValue
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        if (snapshot.data?.snapshot.value != null &&
            snapshot.data?.snapshot.value is Map) {
          final expenses =
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final expensesList = expenses.entries.toList();

          expensesList.sort((a, b) {
            double valueA = double.parse(a.value['value'].toString());
            double valueB = double.parse(b.value['value'].toString());
            return valueB.compareTo(valueA);
          });

          final Map<String, double> chartValues = {};

          int indexes = 0;
          for (var element in expensesList) {
            if (indexes < 5) {
              chartValues[limitString(element.value['expense'], 24)] =
                  convertToEuro(
                double.parse(element.value['value'].toString()),
                element.value['currency'],
              );
            }
            indexes++;
          }

          return Column(
            children: [
              Text(
                expensesChartTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                height: MediaQuery.of(context).size.height / 4,
                child: PieChart(
                  dataMap: chartValues,
                  chartLegendSpacing: 16,
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.right,
                    showLegendsInRow: false,
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValuesInPercentage: true,
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
