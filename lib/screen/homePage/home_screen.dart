import 'dart:io';

import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/car.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  TextEditingController searchcon = TextEditingController();

  String name = "Fatin Fariza";
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: appBarDesign(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            appBarDesign(context).preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 2,
                      child: TextFormField(
                        onChanged: (value) => setState(() => query = value),
                        controller: searchcon,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Car Plate Number",
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            color: const Color(0xffbebebe),
                            fontWeight: FontWeight.w700,
                          ),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchcon.clear();
                                query = '';
                              });
                            },
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 10.w),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      //height: 400,
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                              child: Text(
                                'List Car Currently Parking',
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
                              child: Divider(
                                color: Color(0xffC8C8C8),
                                thickness: 1,
                                height: 0,
                                endIndent: 0,
                                indent: 0,
                              ),
                            ),
                            // SizedBox(height: 25.h),
                            SizedBox(
                              width: double.infinity,
                              height: 340.h,
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                    child: listCurrentCarParkingBuilder(query)),
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
                      ),
                    )
                  ],
                ),
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

  AppBar appBarDesign(BuildContext context) {
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

  Widget listCurrentCarParkingBuilder(String query) {
    //print(query);
    //if (query.isNotEmpty) {
    return StreamBuilder<List<Car>>(
      stream: FirestoreDb().streamCurrentParkingCar(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Car> carList = snapshot.data;

          if (query.isNotEmpty) {
            List<Car> carsTemp = [];
            for (var i = 0; i < carList.length; i++) {
              if (carList[i]
                  .carPlateNum
                  .toLowerCase()
                  .startsWith(query.toLowerCase())) {
                carsTemp.add(carList[i]);
              }
            }
            carList = carsTemp;
          }

          if (carList.isNotEmpty) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                //print(locationParkings.length);
                return ListTile(
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
                    carList[index].carPlateNum, //?? '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(
                    carList[index].carBrand, //?? '',
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
              itemCount: carList.length,
              shrinkWrap: true,
            );
          } else {
            return ListTile(
              title: Text(
                'No Car Found',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            );
          }
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
