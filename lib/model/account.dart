import 'package:flutter/material.dart';

class Account with ChangeNotifier {
  bool isAdmin;
  Account({this.isAdmin = false});

  void setAdmin(bool admin) {
    isAdmin = admin;
    notifyListeners();
  }
}
