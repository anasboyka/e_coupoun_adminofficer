import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/account.dart';
import 'package:e_coupoun_admin/model/admin.dart';
import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/model/officer.dart';
import 'package:e_coupoun_admin/screen/authenticate/authenticate.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/admin_home_screen.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/admin_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/compound_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/driver_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/location_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/officer_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/parking_list.dart';
import 'package:e_coupoun_admin/screen/homePage/officer_home/subpage/officer_home_screen.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useruid = Provider.of<AuthId?>(context);
    final bool isAdmin = Provider.of<Account>(context).isAdmin;

    if (useruid == null) {
      return const AuthenticationPage();
    } else {
      return StreamBuilder<bool>(
        stream: FirestoreDb(uid: useruid.uid).accountIsAdminStream(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            bool isAdmin = snapshot.data;
            if (!isAdmin) {
              return StreamProvider<Officer?>(
                initialData: null,
                create: (context) => FirestoreDb(uid: useruid.uid).officer,
                child: OfficerHomeScreen(),
              );
            } else {
              return StreamProvider<Admin?>(
                initialData: null,
                create: (context) => FirestoreDb(uid: useruid.uid).admin,
                child: AdminHomeScreen(),
              );
            }
          } else {
            return const Scaffold(
              backgroundColor: bgColor,
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
      );
      // if (!isAdmin) {
      //   return StreamProvider<Officer?>(
      //     initialData: null,
      //     create: (context) => FirestoreDb(uid: useruid.uid).officer,
      //     child: OfficerHomeScreen(),
      //   );
      // } else {
      //   return StreamProvider<Admin?>(
      //     initialData: null,
      //     create: (context) => FirestoreDb(uid: useruid.uid).admin,
      //     child: LocationList(),
      //   );
      // }
    }
  }
}
