import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/chat.dart';
import 'package:soccer_app/providers/base_provider.dart';
import 'package:soccer_app/providers/firestore_provider.dart';
import 'package:soccer_app/providers/locator.dart';

class ChatProvider extends BaseProvider {
  List<ChatModel> _conversations = new List.empty(growable: true);
  FirestoreProvider _firestore = locator<FirestoreProvider>();

  List<ChatModel> get conversations => _conversations;

  setConversations(List<ChatModel> conversation) {
    this._conversations = conversation;
    notifyListeners();
  }

  Stream<QuerySnapshot<Object?>> search(String userName) {
    return _firestore.users.where("name", isEqualTo: userName).snapshots();
  }
}
