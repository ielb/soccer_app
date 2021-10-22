import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/user_model.dart';
import 'package:soccer_app/providers/firestore_provider.dart';
import 'package:soccer_app/providers/locator.dart';
import 'package:soccer_app/services/services.dart';

class UserProvider extends BaseProvider {
  FirestoreProvider firestore = locator<FirestoreProvider>();
  UserModel? _userModel;
  UserModel? get user => _userModel;
  setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  getAuthUser(String uid) async {
    DocumentSnapshot<Object?> document =
        await firestore.users.doc(uid).get().catchError((error) {});
    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print(data);
      setUser(UserModel.fromMap(data));
      notifyListeners();
    } else {
      // add to db
    }
  }

  editProfile({required UserModel userModel}) async {
    try {
      await firestore.users
          .doc(userModel.uid)
          .update(userModel.toMap())
          .then((value) => true);
      setUser(userModel);
    } catch (err) {
      print(err);
    }
  }
}
