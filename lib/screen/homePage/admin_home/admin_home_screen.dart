import 'dart:io';

import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/admin.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Admin? admin = Provider.of<Admin?>(context);
    return Scaffold(
      appBar: appBarDesignAdminHome(context, admin),
      backgroundColor: kbgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              appBarDesignAdminHome(context, admin).preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menuDesign('Parking', 'assets/icons/parkingIcon.png',
                      '/adminlocationlist', null),
                  menuDesign('Officer', 'assets/icons/officerImage.png',
                      '/adminofficerlist', null)
                ],
              ),
              gaph(h: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menuDesign('Driver', 'assets/icons/driverimage.png',
                      '/admindriverlist', null),
                  menuDesign('Compound', 'assets/icons/compoundIcon.png',
                      '/admincompoundlist', null),
                ],
              ),
              gaph(h: 30),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBarDesignAdminHome(BuildContext context, Admin? admin) {
    return AppBar(
      toolbarHeight: Platform.isAndroid
          ? 190 - MediaQuery.of(context).padding.top
          : 172 - MediaQuery.of(context).padding.top,
      actions: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.power_settings_new,
              color: Color(0xff17B95B),
            ),
            iconSize: 35,
            splashRadius: 25,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/icons/header.png'),
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: double.infinity,
            //color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/officerIcon.png',
                      height: 26,
                    ),
                    gapw(w: 5),
                    Text(
                      'Hi, ${admin?.name ?? 'name'}',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/icons/mpsp-sungaiPetani.png',
                  width: 99,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column menuDesign(
      String title, String imagePath, String navigationPath, Object? args) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(70),
          splashColor: Colors.green,
          child: Container(
            alignment: Alignment.center,
            height: 150.h,
            width: 150.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffCBF0C1),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 6),
                ]),
            child: Image.asset(
              imagePath,
            ),
          ),
          onTap: () {
            print(title);
            print(args);
            Navigator.of(context).pushNamed(navigationPath, arguments: args);
          },
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.sp,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
