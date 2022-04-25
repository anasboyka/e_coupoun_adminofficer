import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/screen/authenticate/authenticate.dart';
import 'package:e_coupoun_admin/screen/homePage/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useruid = Provider.of<AuthId?>(context);

    if (useruid == null) {
      return AuthenticationPage();
    } else {
      return HomePage();
    }
  }
}
