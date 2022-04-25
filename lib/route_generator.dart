import 'package:e_coupoun_admin/screen/homePage/home_screen.dart';
import 'package:e_coupoun_admin/screen/homePage/subpage/compound_history_page.dart';
import 'package:e_coupoun_admin/screen/homePage/subpage/compound_page.dart';
import 'package:e_coupoun_admin/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => Wrapper());
      case '/compound':
        return CupertinoPageRoute(
          builder: (_) => CompoundPage(
            argument: args as Map<String, dynamic>?,
          ),
        );
      case '/compoundhistory':
        return CupertinoPageRoute(builder: (_) => CompoundHistoryPage());
      default:
        return CupertinoPageRoute(builder: (_) => HomePage());
    }
  }
}
