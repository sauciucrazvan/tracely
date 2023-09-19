import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tracely/backend/keys/encryption_key.dart';

import '../../../frontend/config/messages.dart';
import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertNote(
    String title, String content, bool useMarkdown, bool useEncryption) async {
  String userId = getUID();
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = encrypt.IV.fromLength(8);

  // ENCRYPT CONTENT
  if (useEncryption) {
    final encrypter = encrypt.Encrypter(encrypt.AES(getEncryptionKey()));
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

  // ENCRYPT CONTENT
  if (useEncryption) {
    final encrypter = encrypt.Encrypter(encrypt.AES(getEncryptionKey()));
    final encryptedTitle =
        encrypter.encrypt(title, iv: encrypt.IV.fromLength(8));
    final encryptedContent =
        encrypter.encrypt(content, iv: encrypt.IV.fromLength(8));

    title = encryptedTitle.base64;
    content = encryptedContent.base64;
  }

  await database.child("users/$userId/notes/$id").update({
    'title': title,
    'content': content,
    'useMarkdown': useMarkdown,
    'last_edit': DateTime.now().toString(),
  });
}

void deleteNote(String id) async {
  String userId = getUID();

  await database.child("users/$userId/notes/$id").remove();
}

String decryptNoteText(String encryptedMessage, String iv) {
  final encrypter = encrypt.Encrypter(encrypt.AES(getEncryptionKey()));
  return encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedMessage),
      iv: encrypt.IV.fromBase64(iv));
}

Stream getNotesStream() {
  String userId = getUID();

  return database.child("users/$userId/notes").onValue.asBroadcastStream();
}

/*

  WIDGETS

*/

Widget numberOfNotes(BuildContext context) {
  String userId = getUID();

  return StreamBuilder(
    stream: database.child("users/$userId/notes").onValue.asBroadcastStream(),
    builder: (context, dataSnapshot) {
      int numberOfNotes = 0;

      if (dataSnapshot.hasData && dataSnapshot.data?.snapshot.value is Map) {
        Map<dynamic, dynamic> notesMap =
            dataSnapshot.data?.snapshot.value as Map;
        numberOfNotes = notesMap.length;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              notesSaved,
              style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Text(
                  numberOfNotes.toString(),
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.event_note,
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
