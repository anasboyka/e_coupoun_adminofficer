import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/compound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompoundDetail extends StatefulWidget {
  Compound compound;
  CompoundDetail({Key? key, required this.compound}) : super(key: key);

  @override
  State<CompoundDetail> createState() => _CompoundDetailState();
}

class _CompoundDetailState extends State<CompoundDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: compoundDetailAppbarDesign(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            gaph(h: 30),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 26.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Compound Invoice Number',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: false,
                      ),
                      gaph(h: 3),
                      Text(
                        'Invoice Number',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: false,
                      ),
                      gaph(h: 8),
                      const Divider(
                        color: kgreycolor1,
                        thickness: 1.5,
                        height: 0,
                      ),
                      gaph(h: 14),
                      rowData('Car plate number', widget.compound.carId),
                      gaph(),
                      rowData('Type of offence', widget.compound.offenceType),
                      gaph(),
                      rowData('Car Brand', widget.compound.carBrand),
                      gaph(),
                      rowData(
                          'Date',
                          DateFormat('dd-MM-yyyy')
                              .format(widget.compound.dateIssued)),
                      gaph(),
                      rowData(
                          'Time',
                          DateFormat('h:mm')
                              .format(widget.compound.dateIssued)),
                      gaph(),
                      rowData('Location', widget.compound.locationName),
                      gaph(h: 9),
                      const Divider(
                        color: kgreycolor1,
                        thickness: 1.5,
                        height: 0,
                      ),
                      gaph(h: 11),
                      rowData('Amount',
                          'RM ${widget.compound.amount.toStringAsFixed(0)}')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowData(String title, String data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: const Color(0xff808080),
            ),
          ),
        ),
        //gapw(w: 20),
        //const Spacer(),
        Expanded(
          child: Text(
            data,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: const Color(0xff707070),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  AppBar compoundDetailAppbarDesign() {
    return AppBar(
      title: Text(
        'Compound Detail',
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
