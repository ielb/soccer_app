import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccer_app/models/user_model.dart';
import 'package:soccer_app/preferences/prefs.dart';
import 'package:soccer_app/services/services.dart';

class AuthProvider extends BaseProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  void setUser(UserModel user) {
    _userModel = user;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      if (userCredential.user != null) {
        await Prefs.instance.setUid(userCredential.user!.uid);
        return true;
      } else {
        setMessage('Something went wrong');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print('The password provided is too weak.');
          setMessage('The password provided is too weak.');
          break;
        case 'user-not-found':
          print('There is no account with this email. sign up!');
          setMessage('Invalid email');
          break;
        case 'invalid-email':
          print('The email address is not valid');
          setMessage('Invalid email');
          break;
      }
    }
    return false;
  }

  Future<bool> register(
      {required String email,
      required String userName,
      required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      if (userCredential.user != null) {
        userCredential.user!.sendEmailVerification();
        users.doc(userCredential.user!.uid).set(UserModel(
                uid: userCredential.user!.uid,
                email: email.trim(),
                name: userName.trim())
            .toMap());
        setUser((UserModel(
            uid: userCredential.user!.uid,
            email: email.trim(),
            name: userName.trim())));
        Prefs.instance.setUid(userCredential.user!.uid);
        return true;
      } else
        setMessage("Somthing went wrong");
      return false;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print('The password provided is too weak.');
          setMessage('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          print('The account already exists for that email.');
          setMessage('The account already exists for that email.');
          break;
        case 'invalid-email':
          print('The email address is not valid');
          setMessage('Invalid email');
          break;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().catchError((err) {
        print(err);
      });
      if (googleUser == null) {
        print('if');
        return false;
      } else {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          UserModel userModel = UserModel(
              uid: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? '',
              email: userCredential.user!.email ?? '');
          users.doc(userCredential.user!.uid).set(userModel.toMap());
          setUser(userModel);
          Prefs.instance.setUid(userCredential.user!.uid);
          return true;
        } else
          return false;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return false;
  }
}
