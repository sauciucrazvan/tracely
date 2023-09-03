import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/backend/functions/convert_currencies.dart';
import 'package:tracely/frontend/routes/expenses/expense.dart';

import '../../../backend/domains/expenses/expenses_manipulator.dart';
import '../../../backend/handlers/users/account_handler.dart';
import '../../config/messages.dart';

class BuildExpenses extends StatelessWidget {
  const BuildExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    return StreamBuilder(
      stream: database
          .child("users/${getUID()}/expenses")
          .onValue
          .asBroadcastStream(),
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

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ExpenseWidget(
                  id: entry.key,
                  expense: entry.value['expense'],
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
                  color: Theme.of(context).colorScheme.tertiary,
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
