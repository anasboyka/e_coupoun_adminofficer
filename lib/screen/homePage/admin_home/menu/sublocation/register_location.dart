import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class RegisterLocation extends StatefulWidget {
  const RegisterLocation({Key? key}) : super(key: key);

  @override
  State<RegisterLocation> createState() => _RegisterLocationState();
}

class _RegisterLocationState extends State<RegisterLocation> {
  List<bool> enabled = [true, true, false, false];

  late LocationParking locationParkingInfo;
  // String name = 'name', icNum = 'icNum', phoneNum = '01234567';

  TextEditingController address1con = TextEditingController();
  TextEditingController address2con = TextEditingController();
  TextEditingController latitudecon = TextEditingController();
  TextEditingController longitudecon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<FocusNode> node = List.filled(4, FocusNode());

  List<String> label = [
    'Address 1',
    'Address 2',
    'Latitude(optional)',
    'Longitude(optional)',
    //"Date Of Birth"
  ];

  //DateTime _date = DateTime.now();

  // Future _selectDate(BuildContext context) async {
  //   DateTime? _datePicker = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: DateTime(1970),
  //     lastDate: DateTime(2025),
  //   );

  //   if (_datePicker != null && _datePicker != _date) {
  //     setState(() {
  //       _date = _datePicker;
  //       //dateOfBirth = DateFormat("yyyy-MM-dd").format(_date).toString();
  //       // dateOfBirthcon.text = dateOfBirth;
  //     });
  //     //print(_date.toLocal());
  //     //print(DateFormat("yyyy-MM-dd").format(_date));
  //   }
  // }

  createAlertDialog(BuildContext context, String inputData, String title,
      LocationParking? locationParking) {
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
                    address1con.clear();
                    latitudecon.clear();
                    //usernamecon.clear();
                    address2con.clear();
                    // dateOfBirthcon.text = DateFormat('yyyy-MM-dd')
                    //     .format(DateTime.parse("1111-11-11"));
                    Navigator.of(context).pop();
                  } else if (title == 'Save') {
                    // print(locationParking!.documentID);

                    await FirestoreDb().addLocation(locationParking!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('update success')));
                    //Navigator.of(context).pop();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: registerLocationAppbarDesign(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldDesign(address1con, 0, Icons.wysiwyg),
                textFieldDesign(address2con, 1, Icons.wysiwyg),
                textFieldDesign(latitudecon, 2, Icons.location_on),
                textFieldDesign(longitudecon, 3, Icons.location_on),
                SizedBox(height: 100.h),
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
                            'Save',
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
                            String latitude = latitudecon.text;
                            String longitude = longitudecon.text;
                            String address1 = address1con.text;
                            String address2 = address2con.text;
                            GeoPoint? geo;

                            if (address1.isEmpty && address2.isEmpty) {
                              createAlertDialog(
                                  context,
                                  'Please fill in all the required field',
                                  'Field cannot be empty',
                                  null);
                            } else {
                              if (latitude.isEmpty && longitude.isEmpty) {
                                print('normal');
                                // '225, Bandar Amanjaya, 08000 Sungai Petani Kedah',
                                var addresses = await locationFromAddress(
                                    '$address1,$address2');
                                var address = addresses.first;
                                geo = GeoPoint(
                                    address.latitude, address.longitude);
                                LocationParking locationParking =
                                    LocationParking(
                                  locationName: address1,
                                  locationSubname: address2,
                                  geoPoint: geo,
                                );
                                createAlertDialog(
                                    context,
                                    'Register this location?',
                                    'Save',
                                    locationParking);
                              } else {
                                geo = GeoPoint(double.parse(latitude),
                                    double.parse(longitude));
                                LocationParking locationParking =
                                    LocationParking(
                                  locationName: address1,
                                  locationSubname: address2,
                                  geoPoint: geo,
                                );
                                createAlertDialog(
                                    context,
                                    'Register this location?',
                                    'Save',
                                    locationParking);
                              }
                              //FirestoreDb().addLocation(locationParking);
                            }

                            // if (!isNameValid(namecon.text)) {
                            //   createAlertDialog(context, 'Name cannot be empty',
                            //       'Name', null);
                            // } else if (!isPhoneNumValid(phoneNumcon.text)) {
                            //   createAlertDialog(
                            //       context,
                            //       'Phone Number cannot be empty',
                            //       'Phone Number',
                            //       null);
                            // }
                            // else if (!isUserNameValid(usernamecon.text)) {
                            //   createAlertDialog(context,
                            //       'username cannot be empty', 'username', null);
                            // }
                            // else if (!isIcNumValid(icNumcon.text)) {
                            //   createAlertDialog(
                            //       context,
                            //       'IC Number cannot be empty',
                            //       'IC Number',
                            //       null);
                            // }
                            // else if (!isDateBirthValid(dateOfBirthcon.text)) {
                            //   print('date');
                            //   createAlertDialog(
                            //       context,
                            //       'Date of birth cannot be empty or invalid',
                            //       'Date of birth',
                            //       null);
                            // }
                            // else {
                            //   LocationParking LocationParking = LocationParking(
                            //     name: namecon.text,
                            //     icNum: icNumcon.text,
                            //     phoneNum: phoneNumcon.text,
                            //     email: LocationParkingInfo.email,
                            //     LocationParkingId: LocationParkingInfo.LocationParkingId,
                            //     documentID: LocationParkingInfo.documentID,
                            //     reference: LocationParkingInfo.reference,
                            //     snapshot: LocationParkingInfo.snapshot,
                            //   );
                            //   createAlertDialog(context, 'Save all credential?',
                            //       'Save', LocationParking);
                            // }
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
                                null);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row inputDesign(BoxConstraints constraint, String hintText,
      TextEditingController controller, String assetImage) {
    //print(constraint.maxWidth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          assetImage,
          height: 26,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            height: 26,
            alignment: Alignment.center,
            width:
                (hintText == 'Password' || hintText == 'Password Confirmation')
                    ? constraint.maxWidth - 20 - 52
                    : constraint.maxWidth - 20 - 26,
            child: TextFormField(
              // onTap: () {
              //   if (hintText == "Date of Birth") {
              //     _selectDate(context);
              //   }
              // },

              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                color: Colors.black,
              ),
              readOnly: hintText == "Date of Birth" ? true : false,
              //focusNode: ,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              keyboardType: hintText == "Phone Number"
                  ? TextInputType.phone
                  : hintText == "E-mail Address"
                      ? TextInputType.emailAddress
                      : hintText == "Date of Birth"
                          ? TextInputType.datetime
                          : TextInputType.text,
              //textAlign: TextAlign.center,
              //style: ,

              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  color: const Color(0xffa8a8a8),
                ),
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldDesign(
      TextEditingController controller, int index, IconData icons) {
    return SizedBox(
      width: double.infinity,
      height: 80.h,
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 20.w),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled[index],
                // focusNode: node[0],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: enabled[index] ? Colors.black : Color(0xffBEBEBE),
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  icon: Icon(icons),
                  // Image.asset(
                  //   imagePath,
                  //   width: 26.w,
                  // ),
                  labelText: label[index],
                  labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    //fontSize: 13.sp,
                    color: const Color(0xffbebebe),
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC8C8C8)),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  // if (label[index] != "Date Of Birth") {
                  enabled[index] = !enabled[index];
                  // } else {
                  //   enabled[index] = true;
                  //   _selectDate(context);
                  //   enabled[index] = false;
                  // }
                });
              },
              icon: enabled[index]
                  ? const Icon(Icons.check)
                  : const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }

  AppBar registerLocationAppbarDesign() {
    return AppBar(
      title: Text(
        'Register Location',
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
