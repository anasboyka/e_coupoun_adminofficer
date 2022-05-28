import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/model/compound.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompoundHistoryPage extends StatefulWidget {
  const CompoundHistoryPage({Key? key}) : super(key: key);

  @override
  _CompoundHistoryPageState createState() => _CompoundHistoryPageState();
}

class _CompoundHistoryPageState extends State<CompoundHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final officer = Provider.of<AuthId>(context);
    return Scaffold(
      backgroundColor: const Color(0xffE1F9E0),
      appBar: compoundHistoryAppbarDesign(),
      body: StreamBuilder(
          stream:
              FirestoreDb(uid: officer.uid).streamCarCompoundListByOfficerId(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Compound> compoundList = snapshot.data;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                    //physics:const NeverScrollableScrollPhysics(),
                    itemCount: compoundList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: ListTile(
                            horizontalTitleGap: 0,
                            title: Text(
                              compoundList[index].locationName,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0000000305175782,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Text(
                              '${compoundList[index].carBrand} (${compoundList[index].carId.toUpperCase()})',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xff77838f),
                                letterSpacing: 1.0000000305175782,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            trailing: Text(
                              'Issued : ${DateFormat("yyyy-MM-dd").format(compoundList[index].dateIssued).toString()}',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: Color(0xff77838F),
                                letterSpacing: 0.8571428833007813,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }

  AppBar compoundHistoryAppbarDesign() {
    return AppBar(
      title: Text(
        'Compound History',
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
