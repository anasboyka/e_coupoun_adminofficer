import 'dart:io';

import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/account.dart';
import 'package:e_coupoun_admin/model/car.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OfficerHomeScreen extends StatefulWidget {
  const OfficerHomeScreen({Key? key}) : super(key: key);

  @override
  _OfficerHomeScreenState createState() => _OfficerHomeScreenState();
}

class _OfficerHomeScreenState extends State<OfficerHomeScreen> {
  final AuthService _auth = AuthService();
  TextEditingController searchcon = TextEditingController();
  ScrollController _controllerbar = ScrollController();

  String name = "Fatin Fariza";
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: appBarDesignOfficerHome(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            appBarDesignOfficerHome(context).preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: columnContent(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 70,
                color: Color(0xff16AA10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Generate Compound',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 25.sp,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/compound', arguments: {
                    'carPlateNum': searchcon.text.toUpperCase().trim()
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget columnContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.16),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
            child: Text(
              'Location List',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                color: const Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            child: const Divider(
              color: Color(0xffC8C8C8),
              thickness: 1,
              height: 0,
              endIndent: 0,
              indent: 0,
            ),
          ),
          // SizedBox(height: 25.h),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              //height: 470.h,
              child: Scrollbar(
                // showTrackOnHover: true,
                // controller: _controllerbar,
                // isAlwaysShown: true,
                child: SingleChildScrollView(
                    physics: MediaQuery.of(context).viewInsets.bottom == 0
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    child: listLocationParkingBuilder(query)),
              ),
            ),
          ),
          gaph(h: 25)

          // ListTile(
          //   title: Text(
          //     location[0]['location'] ?? '',
          //     style: TextStyle(
          //       fontFamily: 'Roboto',
          //       fontSize: 18,
          //       color: const Color(0xff000000),
          //       fontWeight: FontWeight.w700,
          //     ),
          //     textAlign: TextAlign.left,
          //   ),
          //   subtitle: Text(
          //     location[0]['subLocation'] ?? '',
          //     style: TextStyle(
          //       fontFamily: 'Roboto',
          //       fontSize: 15,
          //       color: const Color(0xffbebebe),
          //       fontWeight: FontWeight.w700,
          //     ),
          //     textAlign: TextAlign.left,
          //   ),
          //   dense: true,
          //   //horizontalTitleGap: 0,
          //   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  AppBar appBarDesignOfficerHome(BuildContext context) {
    return AppBar(
      toolbarHeight: Platform.isAndroid
          ? 190 - MediaQuery.of(context).padding.top
          : 172 - MediaQuery.of(context).padding.top,
      // leading: Align(
      //   alignment: Alignment.topLeft,
      //   child: Builder(
      //     builder: (context) => IconButton(
      //       iconSize: 35,
      //       icon: Icon(
      //         Icons.menu,
      //         color: Color(0xff17B95B),
      //       ),
      //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //       splashRadius: 25,
      //       onPressed: () {
      //         print('clicked');
      //         return Scaffold.of(context).openDrawer();
      //       },
      //     ),
      //   ),
      // ),
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
                      'Hi, ${name}',
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

  Widget listLocationParkingBuilder(String query) {
    //print(query);
    //if (query.isNotEmpty) {
    return StreamBuilder<List<LocationParking>>(
      stream: FirestoreDb().locations,
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<LocationParking> locationList = snapshot.data;

          // if (query.isNotEmpty) {
          //   List<LocationParking> carsTemp = [];
          //   for (var i = 0; i < locationList.length; i++) {
          //     if (locationList[i]
          //         .carPlateNum
          //         .toLowerCase()
          //         .startsWith(query.toLowerCase())) {
          //       carsTemp.add(locationList[i]);
          //     }
          //   }
          //   locationList = carsTemp;
          // }

          // if (locationList.isNotEmpty) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              //print(locationParkings.length);
              return Material(
                child: ListTile(
                  onTap: () {
                    //print('tapped ${locationList[index].documentID}');
                    Navigator.of(context).pushNamed('/officerLocationView',
                        arguments: locationList[index]);
                    //todo navigate to location selection
                  },
                  leading: SizedBox(
                    height: 36.h,
                    width: 36.w,
                    child: Icon(
                      Icons.directions_car,
                      size: 36.w,
                      color: Color(0xff17B95B),
                    ),
                  ),
                  title: Text(
                    locationList[index].locationName, //?? '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(
                    locationList[index].locationSubname, //?? '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      color: const Color(0xffbebebe),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  dense: true,
                  //horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Divider(
                  color: Color(0xffC8C8C8),
                  thickness: 1,
                  height: 0,
                  endIndent: 0,
                  indent: 0,
                ),
              );
            },
            itemCount: locationList.length,
            shrinkWrap: true,
          );
          // } else {
          //   return ListTile(
          //     title: Text(
          //       'No Car Found',
          //       style: TextStyle(
          //         fontFamily: 'Roboto',
          //         fontSize: 16.sp,
          //         color: const Color(0xff707070),
          //         fontWeight: FontWeight.w700,
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //   );
          // }
        } else {
          print('loading');
          return Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: const Center(child: CircularProgressIndicator.adaptive()),
          );
        }
      },
    );
    // } else {
    //   return ListTile(
    //     title: Text(
    //       'Please input car plate number',
    //       style: TextStyle(
    //         fontFamily: 'Roboto',
    //         fontSize: 16.sp,
    //         color: const Color(0xff707070),
    //         fontWeight: FontWeight.w700,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   );
    // }
  }

  Column menuDesign(String title, String imagePath, String navigationPath) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(70),
          splashColor: Colors.green,
          child: Container(
            alignment: Alignment.center,
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
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
            Navigator.of(context).pushNamed(navigationPath);
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
