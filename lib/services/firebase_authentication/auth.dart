import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/model/officer.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthId _userFromFirebaseUser(User? user) {
    return AuthId(uid: user!.uid);
  }

  Stream<AuthId> get user {
    return _auth
        .authStateChanges()
        .map((event) => _userFromFirebaseUser(event));
  }

  Future registerOfficerWithEmailAndPasword(
      {required String password, required Officer officer}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: officer.email, password: password);
      User? user = credential.user;
      return user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'passwordweak';
      } else if (e.code == 'email-already-in-use') {
        return 'emailUsed';
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerAdminWithEmailAndPasword(
      {required String password, required Officer officer}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: officer.email, password: password);
      User? user = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'passwordweak';
      } else if (e.code == 'email-already-in-use') {
        return 'emailUsed';
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAdminWithEmailAndPassword(String email, String password) async {
    try {
      bool isAdmin = await FirestoreDb().accountIsAdmin(email);
      if (isAdmin) {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User? user = credential.user;
        print(credential.user);
        if (credential.user == null) {
          return null;
        } else {
          //TODO check if uid belong to admin
          if (credential.user != null) {
            return credential.user;
          } else {
            return credential.user;
          }
        }
      } else {
        return 'admin account not exist';
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInOfficerWithEmailAndPassword(
      String email, String password) async {
    try {
      bool isOfficer = await FirestoreDb().accountIsOfficer(email);
      if (isOfficer) {
        print('is officer = true');
        UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User? user = credential.user;
        //print(credential.user);
        if (user == null) {
          return null;
        } else {
          //TODO check if uid belong to officer
          if (credential.user != null) {
            return credential.user;
          } else {
            return credential.user;
          }
        }
      } else {
        return 'officer account not exist';
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
