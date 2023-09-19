import 'package:firebase_database/firebase_database.dart';

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

Stream getExpensesStream() {
  String userId = getUID();

  return database.child("users/$userId/expenses").onValue.asBroadcastStream();
}
