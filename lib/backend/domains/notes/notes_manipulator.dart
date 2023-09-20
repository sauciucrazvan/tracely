import 'package:encrypt/encrypt.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:tracely/backend/keys/encryption_key.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertNote(
    String title, String content, bool useMarkdown, bool useEncryption) async {
  String userId = getUID();
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = IV.fromLength(8);

  // ENCRYPT CONTENT
  if (useEncryption) {
    final encrypter = Encrypter(AES(getEncryptionKey()));
    final encryptedTitle = encrypter.encrypt(title, iv: iv);
    final encryptedContent = encrypter.encrypt(content, iv: iv);

    title = encryptedTitle.base64;
    content = encryptedContent.base64;
  }

  await database.child("users/$userId/notes/$id").set({
    'title': title,
    'content': content,
    'iv': iv.base64,
    'useMarkdown': useMarkdown,
    'useEncryption': useEncryption,
    'last_edit': DateTime.now().toString(),
  });
}

void editNote(String id, String title, String content, bool useMarkdown,
    bool useEncryption) async {
  String userId = getUID();

  IV iv = IV.fromLength(8);
  // ENCRYPT CONTENT
  if (useEncryption) {
    final encrypter = Encrypter(AES(getEncryptionKey()));
    final encryptedTitle = encrypter.encrypt(title, iv: iv);
    final encryptedContent = encrypter.encrypt(content, iv: iv);

    title = encryptedTitle.base64;
    content = encryptedContent.base64;
  }

  await database.child("users/$userId/notes/$id").update({
    'title': title,
    'content': content,
    'iv': iv.base64,
    'useMarkdown': useMarkdown,
    'last_edit': DateTime.now().toString(),
  });
}

void deleteNote(String id) async {
  String userId = getUID();

  await database.child("users/$userId/notes/$id").remove();
}

Stream getNotesStream() {
  String userId = getUID();

  return database.child("users/$userId/notes").onValue.asBroadcastStream();
}
