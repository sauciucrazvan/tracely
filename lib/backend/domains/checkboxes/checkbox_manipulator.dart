import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/backend/keys/encryption_key.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertCheckbox(String categoryID, String name, String date) async {
  String userId = getUID();

  String checkboxID = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(name, iv: iv).base64;

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .set({
    'title': encryptedTitle,
    'iv': iv.base64,
    'date': date,
    'checked': false,
  });
}

void markCheckbox(String categoryID, String checkboxID, bool value) async {
  String userId = getUID();

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .update({
    'checked': value,
  });
}

void updateCheckbox(
    String categoryID, String checkboxID, String name, String date) async {
  String userId = getUID();

  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(name, iv: iv).base64;

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .update({
    'title': encryptedTitle,
    'iv': iv.base64,
    'date': date,
  });
}

void encryptCheckbox(
    String categoryID, String checkboxID, String checklist) async {
  String userId = getUID();

  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(checklist, iv: iv).base64;

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .update({
    'title': encryptedTitle,
    'iv': iv.base64,
  });
}

void deleteCheckbox(String categoryID, String checkboxID) async {
  String userId = getUID();

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .remove();
}
