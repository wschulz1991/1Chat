import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class App1CHATFirebaseUser {
  App1CHATFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

App1CHATFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<App1CHATFirebaseUser> app1CHATFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<App1CHATFirebaseUser>(
            (user) => currentUser = App1CHATFirebaseUser(user));
