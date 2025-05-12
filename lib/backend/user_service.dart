import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  //Registrierung
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateProfile(displayName: name);
    await userCredential.user?.reload();
    return userCredential.user;
  }

  //Login
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.reload();
    return _auth.currentUser;
  }

  //Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //Account löschen
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          throw Exception(
            'User needs to reauthenticate before deleting the account.',
          );
        } else {
          throw Exception('Failed to delete account: ${e.message}');
        }
      }
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  // Passwort zurücksetzen
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
