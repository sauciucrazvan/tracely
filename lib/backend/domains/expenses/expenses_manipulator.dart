import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../frontend/config/messages.dart';
import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertExpense(
    String expense, String currency, double value, String date) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/expenses/$id").set({
    'expense': expense,
    'currency': currency,
    'value': value,
    'date': date,
  });
}

void editExpense(String id, String expense, String currency, double value,
    String date) async {
  String userId = getUID();

  await database.child("users/$userId/expenses/$id").update({
    'expense': expense,
    'currency': currency,
    'value': value,
    'date': date,
  });
}

void deleteExpense(String id) async {
  String userId = getUID();

  await database.child("users/$userId/expenses/$id").remove();
}

/*

  WIDGETS

*/

Widget numberOfExpenses(BuildContext context) {
  String userId = getUID();

  return StreamBuilder(
    stream:
        database.child("users/$userId/expenses").onValue.asBroadcastStream(),
    builder: (context, dataSnapshot) {
      int numberOfExpenses = 0;

      if (dataSnapshot.hasData && dataSnapshot.data?.snapshot.value is Map) {
        Map<dynamic, dynamic> expensesMap =
            dataSnapshot.data?.snapshot.value as Map;
        numberOfExpenses = expensesMap.length;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              expensesSaved,
              style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Text(
                  numberOfExpenses.toString(),
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.wallet,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
