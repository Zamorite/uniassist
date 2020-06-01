import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  //***** Initialize instances of classes required for auth
  GoogleSignIn _gsi = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _store = Firestore();

  Stream<FirebaseUser> user;
  Stream<Map<String, dynamic>> profile;
  PublishSubject loading = new PublishSubject();

  //***** Class Constructor
  AuthService() {
    user = _auth.onAuthStateChanged;
    profile = user.switchMap((FirebaseUser u) => (u != null)
        ? _store
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data)
        : Stream.empty());
  }

  //***** Google Social Authentication
  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _gsi.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;

    updateUserData(user);
    print('[i]    ${user.displayName} logged in.');

    loading.add(false);

    return user;
  }

  //***** Updating User data from Social Account
  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _store.collection('users').document('uid');

    ref.setData(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoUrl,
        'displayName': user.displayName,
        'lastSeen': DateTime.now(),
      },
      merge: true,
    );
  }

  //***** Signing Out
  signout() {
    _auth.signOut();
  }
}
