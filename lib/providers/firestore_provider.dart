import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/providers/base_provider.dart';

class FirestoreProvider extends BaseProvider {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');
}
