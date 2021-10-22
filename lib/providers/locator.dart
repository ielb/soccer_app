import 'package:get_it/get_it.dart';
import 'package:soccer_app/providers/firestore_provider.dart';
import 'package:soccer_app/providers/user_provider.dart';

import 'auth_provider.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<FirestoreProvider>(FirestoreProvider());
  locator.registerSingleton<UserProvider>(UserProvider());
  locator.registerSingleton<AuthProvider>(AuthProvider());
}
