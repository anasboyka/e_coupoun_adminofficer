import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/compound.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompoundList extends StatefulWidget {
  const CompoundList({Key? key}) : super(key: key);

  @override
  State<CompoundList> createState() => _CompoundListState();
}

class _CompoundListState extends State<CompoundList> {
  String query = '';

  TextEditingController searchcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: compoundListAppbarDesign(),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom == 0
            ? const NeverScrollableScrollPhysics()
            : null,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              compoundListAppbarDesign().preferredSize.height -
              MediaQuery.of(context).padding.top,
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
                      hintText: "Search Compound",
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
                          searchcon.clear();
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
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                            child: const Text(
                              'Compound List',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                            child: const Divider(
                              color: Color(0xffC8C8C8),
                              thickness: 1,
                              height: 0,
                              endIndent: 0,
                              indent: 0,
                            ),
                          ),
                          // SizedBox(height: 25.h),
                          Expanded(child: listCompoundBuilder(query)),
                          gaph(h: 30)
                        ],
                      ),
                    ),
                  ),
                ),
                gaph(),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Colors.white,
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.grey,
                //           offset: Offset(0, 1),
                //           blurRadius: 1,
                //         )
                //       ]),
                //   child: Material(
                //     clipBehavior: Clip.hardEdge,
                //     color: Colors.transparent,
                //     shadowColor: Colors.transparent,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.r),
                //     ),
                //     child: ListTile(
                //       contentPadding:
                //           EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                //       leading: Icon(
                //         Icons.add,
                //         size: 35.w,
                //         color: Color(0xff17B95B),
                //       ),
                //       horizontalTitleGap: 4.w,
                //       title: Text(
                //         'Register New Location',
                //         style: TextStyle(
                //           fontFamily: 'Roboto',
                //           fontSize: 16.sp,
                //           color: const Color(0xff000000),
                //           fontWeight: FontWeight.w700,
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //       onTap: () async {
                //         // Navigator.of(context).pushNamed('/registerinputcar', arguments: {
                //         //   "appbarTitle": "Register New Car",
                //         //   "driverInfo": widget.driverInfo
                //         // });
                //         print('tap');
                //       },
                //     ),
                //   ),
                // ),
                // gaph()
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Compound>> listCompoundBuilder(String query) {
    //print(query);
    return StreamBuilder<List<Compound>>(
      stream: FirestoreDb().compounds,
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Compound> compoundList = snapshot.data;
          if (query.isNotEmpty) {
            List<Compound> locationCompoundsTemp = [];
            for (var i = 0; i < compoundList.length; i++) {
              if (compoundList[i]
                  .locationName
                  .toLowerCase()
                  .startsWith(query.toLowerCase())) {
                locationCompoundsTemp.add(compoundList[i]);
              }
            }
            compoundList = locationCompoundsTemp;
          }

          if (compoundList.isNotEmpty) {
            return Scrollbar(
              child: ListView.separated(
                physics: MediaQuery.of(context).viewInsets.bottom == 0
                    ? null
                    : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  //print(locationParkings.length);
                  return ListTile(
                    onTap: () {
                      //Todo navigate to compound detail
                      Navigator.of(context).pushNamed('/admincompounddetail',
                          arguments: compoundList[index]);
                    },
                    title: Text(
                      compoundList[index].invoiceNum, //?? '',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   '${locationCompounds[index].locationName.toUpperCase()} ', //?? '',
                        //   style: const TextStyle(
                        //     fontFamily: 'Roboto',
                        //     fontSize: 15,
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        Text(
                          '${compoundList[index].carBrand.toUpperCase()}(${compoundList[index].carId.toUpperCase()})', //?? '',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            color: Color(0xffbebebe),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SizedBox(
                        //   width: 30.w,
                        //   height: 30.h,
                        //   child: Material(
                        //     shape: const CircleBorder(),
                        //     child: IconButton(
                        //       highlightColor: Colors.transparent,
                        //       padding: const EdgeInsets.all(0),
                        //       iconSize: 30.w,
                        //       onPressed: () {
                        //         //todo
                        //       },
                        //       icon: Icon(
                        //         Icons.edit,
                        //         color: Color(0xff17B95B),
                        //         size: 30,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: 6.w),
                        SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: Material(
                            shape: CircleBorder(),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              iconSize: 30.w,
                              onPressed: () {
                                //TOdo
                                print(compoundList[index].documentID!);
                                createAlertDialog(
                                    context, compoundList[index].documentID!);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xff17B95B),
                                size: 30.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //isThreeLine: true,
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
                itemCount: compoundList.length,
                shrinkWrap: true,
              ),
            );
          } else {
            return ListTile(
              title: Text(
                'Location not found',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        } else {
          print('loading');
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }

  createAlertDialog(BuildContext context, String compoundId) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Compound',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19.sp,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Are you sure you want to delete compound ?',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19.sp,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              InkWell(
                child: Container(
                  width: 74.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff17B95B),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () async {
                  await FirestoreDb().deleteCompoundById(compoundId);
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  width: 74.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffF04437),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43.h, 9.w, 15.h),
            buttonPadding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 0),
            contentPadding: EdgeInsets.fromLTRB(27.w, 20.h, 15.w, 0),
            insetPadding: EdgeInsets.fromLTRB(55.w, 0, 55.w, 0),
            titlePadding: EdgeInsets.fromLTRB(27.w, 27.h, 27, 0),
          );
        });
  }

  AppBar compoundListAppbarDesign() {
    return AppBar(
      title: Text(
        'Compound',
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
