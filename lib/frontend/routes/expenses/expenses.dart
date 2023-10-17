import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:tracely/backend/functions/convert_currencies.dart';
import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';
import 'package:tracely/backend/functions/decrypt.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/routes/expenses/expense.dart';

class BuildExpenses extends StatelessWidget {
  const BuildExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getExpensesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Lottie.asset(
              "assets/animations/magic.json",
              width: 128,
              height: 128,
            ),
          );
        }

        if (snapshot.data?.snapshot.value != null &&
            snapshot.data?.snapshot.value is Map) {
          final expenses =
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final expensesList = expenses.entries.toList();

          // sort by price
          expensesList.sort((a, b) {
            double valueA = convertToEuro(
                double.parse(a.value['value'].toString()), a.value['currency']);
            double valueB = convertToEuro(
                double.parse(b.value['value'].toString()), b.value['currency']);
            return valueB.compareTo(valueA);
          });

          return Column(
            children: expensesList.map((entry) {
              // Deleting expenses older than 60 days
              if (DateTime.parse(entry.value['date']).isBefore(
                DateTime.now().subtract(
                  const Duration(days: 60),
                ),
              )) {
                deleteExpense(entry.key);
              }

              String expense = entry.value['expense'];

              if (entry.value['iv'] == null) {
                encryptExpense(entry.key, entry.value['expense']);
                return const CircularProgressIndicator();
              }

              expense = decryptText(expense, entry.value['iv']);

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ExpenseWidget(
                  id: entry.key,
                  expense: expense,
                  value: double.parse(entry.value['value'].toString()),
                  currency: entry.value['currency'],
                  date: entry.value['date'],
                ),
              );
            }).toList(),
          );
        }

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/error.json",
                width: 256,
                height: 256,
              ),
              Text(
                noExpensesSaved,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
