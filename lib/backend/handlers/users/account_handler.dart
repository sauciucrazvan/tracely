import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth instance = FirebaseAuth.instance;
User currentUser = instance.currentUser!;

User getUser() => currentUser;

void setUser(User user) => currentUser = user;

String getName() => currentUser.displayName!;
String getUID() => currentUser.uid;

void signOutUser() async {
  // FIREBASE SIGN OUT
  instance.signOut();

  // GOOGLE SIGN OUT
  if (await GoogleSignIn().isSignedIn()) GoogleSignIn().signOut();
}
