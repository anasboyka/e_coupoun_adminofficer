import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/driver.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/model/officer.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfficerList extends StatefulWidget {
  const OfficerList({Key? key}) : super(key: key);

  @override
  State<OfficerList> createState() => _OfficerListState();
}

class _OfficerListState extends State<OfficerList> {
  String query = '';

  TextEditingController searchcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: officerListAppbarDesign(),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom == 0
            ? const NeverScrollableScrollPhysics()
            : null,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              officerListAppbarDesign().preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: StreamBuilder(
                stream: FirestoreDb().officers,
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Officer> officerList = snapshot.data;
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  elevation: 2,
                                  child: ExpansionTile(
                                    title: const Text(
                                      'Officer List',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        color: const Color(0xff707070),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    children: officerList.map((e) {
                                      return Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Divider(
                                              color: kgreycolor1,
                                              thickness: 1.5,
                                              height: 0,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(e.name.isNotEmpty
                                                ? e.name
                                                : 'name not updated'),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  child: Material(
                                                    shape: const CircleBorder(),
                                                    child: IconButton(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      iconSize: 30.w,
                                                      onPressed: () {
                                                        //todo
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color:
                                                            Color(0xff17B95B),
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 6.w),
                                                SizedBox(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  child: Material(
                                                    shape: const CircleBorder(),
                                                    child: IconButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      iconSize: 30.w,
                                                      onPressed: () {
                                                        //Todo
                                                        // print(locationCompounds[index].documentID!);
                                                        // createAlertDialog(context,
                                                        //     locationCompounds[index].documentID!);
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: const Color(
                                                            0xff17B95B),
                                                        size: 30.w,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                                gaph(h: 30)
                              ],
                            ),
                          ),
                        ),
                        gaph(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                )
                              ]),
                          child: Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              leading: Icon(
                                Icons.add,
                                size: 35.w,
                                color: Color(0xff17B95B),
                              ),
                              horizontalTitleGap: 4.w,
                              title: Text(
                                'Register New Officer',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.sp,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onTap: () async {
                                // Navigator.of(context).pushNamed('/registerinputcar', arguments: {
                                //   "appbarTitle": "Register New Car",
                                //   "driverInfo": widget.driverInfo
                                // });
                                print('tap');
                              },
                            ),
                          ),
                        ),
                        gaph()
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

  // StreamBuilder<List<LocationParking>> listLocationParkingBuilder(
  //     String query) {
  //   //print(query);
  //   return StreamBuilder(
  //     stream: FirestoreDb().locations,
  //     builder: (_, AsyncSnapshot snapshot) {
  //       if (snapshot.hasData) {
  //         List<LocationParking> locationParkings = snapshot.data;
  //         if (query.isNotEmpty) {
  //           List<LocationParking> locationParkingsTemp = [];
  //           for (var i = 0; i < locationParkings.length; i++) {
  //             if (locationParkings[i]
  //                 .locationName
  //                 .toLowerCase()
  //                 .startsWith(query.toLowerCase())) {
  //               locationParkingsTemp.add(locationParkings[i]);
  //             }
  //           }
  //           locationParkings = locationParkingsTemp;
  //         }

  //         if (locationParkings.isNotEmpty) {
  //           return Scrollbar(
  //             child: ListView.separated(
  //               physics: MediaQuery.of(context).viewInsets.bottom == 0
  //                   ? null
  //                   : const NeverScrollableScrollPhysics(),
  //               itemBuilder: (context, index) {
  //                 //print(locationParkings.length);
  //                 return ListTile(
  //                   title: Text(
  //                     locationParkings[index].locationName, //?? '',
  //                     style: const TextStyle(
  //                       fontFamily: 'Roboto',
  //                       fontSize: 18,
  //                       color: const Color(0xff000000),
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                     textAlign: TextAlign.left,
  //                   ),
  //                   subtitle: Text(
  //                     locationParkings[index].locationSubname, //?? '',
  //                     style: const TextStyle(
  //                       fontFamily: 'Roboto',
  //                       fontSize: 15,
  //                       color: const Color(0xffbebebe),
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                     textAlign: TextAlign.left,
  //                   ),
  //                   dense: true,
  //                   //horizontalTitleGap: 0,
  //                   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
  //                   onTap: () {
  //                     //Todo
  //                     // Navigator.of(context)
  //                     //     .pop({'locationParking': locationParkings[index]});
  //                   },
  //                 );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                   child: Divider(
  //                     color: Color(0xffC8C8C8),
  //                     thickness: 1,
  //                     height: 0,
  //                     endIndent: 0,
  //                     indent: 0,
  //                   ),
  //                 );
  //               },
  //               itemCount: locationParkings.length,
  //               shrinkWrap: true,
  //             ),
  //           );
  //         } else {
  //           return ListTile(
  //             title: Text(
  //               'Location not found',
  //               style: TextStyle(
  //                 fontFamily: 'Roboto',
  //                 fontSize: 16.sp,
  //                 color: const Color(0xff707070),
  //                 fontWeight: FontWeight.w700,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           );
  //         }
  //       } else {
  //         print('loading');
  //         return CircularProgressIndicator.adaptive();
  //       }
  //     },
  //   );
  // }

  AppBar officerListAppbarDesign() {
    return AppBar(
      title: Text(
        'Manage Officer Account',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22.sp,
          color: const Color(0xff707070),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      leading: Builder(
        builder: (context) => IconButton(
          iconSize: 35.w,
          icon: Icon(
            Icons.chevron_left,
            color: Color(0xff17B95B),
          ),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          splashRadius: 25,
          onPressed: () {
            return Navigator.of(context).pop();
          },
        ),
      ),
      actions: [],
      flexibleSpace: Image(
        image: AssetImage('assets/icons/header.png'),
        fit: BoxFit.fitWidth,
      ),
      elevation: 1,
    );
  }
}
