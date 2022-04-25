import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/model/compound.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompoundPage extends StatefulWidget {
  Map? argument;

  CompoundPage({Key? key, this.argument}) : super(key: key);

  @override
  _CompoundPageState createState() => _CompoundPageState();
}

class _CompoundPageState extends State<CompoundPage> with InputValidationMixin {
  TextEditingController carPlateNumcon = TextEditingController();
  TextEditingController carTypecon = TextEditingController();
  TextEditingController carOffenceTypecon = TextEditingController();
  TextEditingController carDateCompoundcon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String date = '';

  List<String> label = [
    'Car Plate Number',
    'Car Type',
    "Type Of Offence",
    "Date",
  ];

  DateTime _date = DateTime.now();

  Future _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffF9F42B), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.green, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kbtnColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        date = DateFormat("yyyy-MM-dd").format(_date).toString();
        carDateCompoundcon.text = date;
      });
      //print(_date.toLocal());
      //print(DateFormat("yyyy-MM-dd").format(_date));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carPlateNumcon = widget.argument!["carPlateNum"] != null
        ? TextEditingController(text: widget.argument!["carPlateNum"])
        : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final officer = Provider.of<AuthId>(context);
    return Scaffold(
      backgroundColor: Color(0xffE1F9E0),
      appBar: compoundAppbarDesign(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                gaph(h: 24),
                textFieldDesign(
                  carPlateNumcon,
                  0,
                ),
                gaph(h: 25),
                textFieldDesign(
                  carTypecon,
                  1,
                ),
                gaph(h: 25),
                textFieldDesign(
                  carOffenceTypecon,
                  2,
                ),
                gaph(h: 25),
                textFieldDesign(
                  carDateCompoundcon,
                  3,
                ),
                SizedBox(height: 120.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                            //minWidth: size.width / 2 - 30.w,
                            minHeight: 62.h,
                            maxHeight: 66.h,
                            minWidth: double.infinity
                            //maxHeight: 40,
                            ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff16AA32),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20.sp,
                              color: const Color(0xffffffff),
                              letterSpacing: 1.0714286041259766,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            if (!isCarPlateNumValid(carPlateNumcon.text)) {
                              //print('name');
                              createAlertDialog(
                                context,
                                'Plate Number cannot be empty',
                                'Car Plate Number',
                              );
                            } else if (!isCarTypeValid(carTypecon.text)) {
                              //print('phone');
                              createAlertDialog(
                                context,
                                'Car type cannot be empty',
                                'Car Type',
                              );
                            } else if (!isTypeOfOffenceValid(
                                carOffenceTypecon.text)) {
                              //print('Ic num');
                              createAlertDialog(
                                context,
                                'Type of offence cannot be empty',
                                'Type Of Offence',
                              );
                            } else if (!isDateCompoundValid(
                                carDateCompoundcon.text)) {
                              //print('date');
                              createAlertDialog(
                                context,
                                'Date Compound cannot be empty',
                                'Compound Date',
                              );
                            } else {
                              //TODO database
                              String invoiceNum = DateFormat('yyyyMMddHms')
                                  .format(DateTime.now());

                              Compound compound = Compound(
                                  amount: 2000,
                                  isPaid: false,
                                  carId: carPlateNumcon.text,
                                  dateIssued: DateTime.now(),
                                  officerId: officer.uid,
                                  locationId: 'locationId',
                                  locationName: 'locationName',
                                  invoiceNum: invoiceNum);
                              print(invoiceNum);
                              //FirestoreDb(uid: officer.uid).updateCompoundDataCollection(compound)
                              createAlertDialog(
                                  context, 'Generate Compound?', 'Submit');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                            //minWidth: size.width / 2 - 30.w,
                            minHeight: 62.h,
                            maxHeight: 66.h,
                            minWidth: double.infinity
                            //maxHeight: 40,
                            ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20.sp,
                              color: const Color(0xffBEBEBE),
                              letterSpacing: 1.0714286041259766,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            createAlertDialog(
                              context,
                              'Are you sure you want to clear all credential?',
                              'Clear',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                gaph(),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  color: kbtnColor,
                  height: 67,
                  minWidth: double.infinity,
                  child: Text(
                    'View Compound History',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 20.sp,
                      color: const Color(0xffffffff),
                      letterSpacing: 1.0714286041259766,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/compoundhistory');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar compoundAppbarDesign() {
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

  createAlertDialog(BuildContext context, String inputData, String title) {
    Size size = MediaQuery.of(context).size;

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              inputData,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffF04437),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  //Navigator.of(context).pop("data from dialog");
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff16AA32),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () async {
                  if (title == 'Clear') {
                    carDateCompoundcon.text = '';
                    Navigator.of(context).pop();
                  } else if (title == 'Save') {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43, 9, 15),
            buttonPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            contentPadding: EdgeInsets.fromLTRB(27, 20, 15, 0),
            insetPadding: EdgeInsets.fromLTRB(55, 0, 55, 0),
            titlePadding: EdgeInsets.fromLTRB(27, 27, 27, 0),
          );
        });
  }

  Widget textFieldDesign(TextEditingController controller, int index) {
    return Container(
      width: double.infinity,
      height: 80.h,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 20.w),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: label[index] != 'Date' ? true : false,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  labelText: label[index],
                  labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    color: const Color(0xffbebebe),
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC8C8C8)),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC8C8C8)),
                  ),
                ),
              ),
            ),
            label[index] != 'Date'
                ? gapw(w: 45)
                : IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isCarPlateNumValid(String? carPlateNum) =>
      carPlateNum != null ? carPlateNum.isNotEmpty : false;

  bool isCarTypeValid(String? carType) =>
      carType != null ? carType.isNotEmpty : false;

  bool isUserNameValid(String? username) =>
      username != null ? username.isNotEmpty : false;

  bool isTypeOfOffenceValid(String? typeOfOffence) =>
      typeOfOffence != null ? typeOfOffence.isNotEmpty : false;

  bool isDateCompoundValid(String? dateCompound) =>
      dateCompound != null ? dateCompound.isNotEmpty : false;
}
