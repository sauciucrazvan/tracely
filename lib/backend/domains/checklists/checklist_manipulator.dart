import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/backend/keys/encryption_key.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertChecklist(String name, String color) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(name, iv: iv).base64;

  await database.child("users/$userId/checklists/$id").set({
    'title': encryptedTitle,
    'iv': iv.base64,
    'color': color,
  });
}

void editChecklist(String id, String name, String color) async {
  String userId = getUID();
  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(name, iv: iv).base64;

  await database.child("users/$userId/checklists/$id").update({
    'title': encryptedTitle,
    'iv': iv.base64,
    'color': color,
  });
}

void markChecklistPinned(String id, bool pinned) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").update({
    'pinned': !pinned,
  });
}

void deleteChecklist(String id) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").remove();
}

void encryptChecklist(String checklistId, String checklist) async {
  String userId = getUID();

  IV iv = IV.fromLength(8);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedTitle = encrypter.encrypt(checklist, iv: iv).base64;

  await database.child("users/$userId/checklists/$checklistId").update({
    'title': encryptedTitle,
    'iv': iv.base64,
  });
}

Stream getChecklistsStream() {
  String userId = getUID();

  return database.child("users/$userId/checklists").onValue.asBroadcastStream();
}
