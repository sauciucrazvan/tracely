import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tracely/backend/keys/encryption_key.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertExpense(
    String expense, String currency, double value, String date) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedExpense = encrypter.encrypt(expense, iv: iv).base64;

  await database.child("users/$userId/expenses/$id").set({
    'expense': encryptedExpense,
    'currency': currency,
    'value': value,
    'date': date,
    'iv': iv.base64,
  });
}

void editExpense(String id, String expense, String currency, double value,
    String date) async {
  String userId = getUID();

  IV iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedExpense = encrypter.encrypt(expense, iv: iv).base64;

  await database.child("users/$userId/expenses/$id").update({
    'expense': encryptedExpense,
    'currency': currency,
    'value': value,
    'date': date,
    'iv': iv.base64,
  });
}

void deleteExpense(String id) async {
  String userId = getUID();

  await database.child("users/$userId/expenses/$id").remove();
}

void encryptExpense(String expenseId, String expense) async {
  String userId = getUID();

  IV iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedExpense = encrypter.encrypt(expense, iv: iv).base64;

  await database.child("users/$userId/expenses/$expenseId").update({
    'expense': encryptedExpense,
    'iv': iv.base64,
  });
}

Stream getExpensesStream() {
  String userId = getUID();

  return database.child("users/$userId/expenses").onValue.asBroadcastStream();
}
