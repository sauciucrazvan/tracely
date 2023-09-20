import 'package:encrypt/encrypt.dart';
import 'package:tracely/backend/keys/encryption_key.dart';

String decryptText(String encryptedMessage, String iv) {
  final encrypter = Encrypter(AES(getEncryptionKey()));
  return encrypter.decrypt(Encrypted.fromBase64(encryptedMessage),
      iv: IV.fromBase64(iv));
}
