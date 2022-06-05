import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/officer.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:e_coupoun_admin/services/firebase_firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nanoid/async.dart';

class RegisterOfficer extends StatefulWidget {
  const RegisterOfficer({Key? key}) : super(key: key);

  @override
  State<RegisterOfficer> createState() => _RegisterOfficerState();
}

class _RegisterOfficerState extends State<RegisterOfficer> {
  bool isHidden2 = true;
  bool isHidden1 = true;
  bool loading = false;

  final fullnamecon = TextEditingController();
  final officeridcon = TextEditingController();
  final phoneNumcon = TextEditingController();
  final emailcon = TextEditingController();
  final icNumcon = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgColor,
        appBar: registerOfficerAppbarDesign(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 36.h, 50.w, 44.h),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(28.w, 38.h, 28.w, 52.h),
                    child: LayoutBuilder(builder: (context, constraint) {
                      return Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            inputDesign(constraint, 'Full Name', fullnamecon,
                                'assets/icons/nameIcon.png'),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
                              child: const Divider(
                                color: kgreycolor1,
                                thickness: 1.5,
                                height: 0,
                              ),
                            ),
                            inputDesign(constraint, 'Phone Number', phoneNumcon,
                                'assets/icons/phoneNumberIcon.png'),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
                              child: const Divider(
                                color: kgreycolor1,
                                thickness: 1.5,
                                height: 0,
                              ),
                            ),
                            inputDesign(constraint, 'E-mail Address', emailcon,
                                'assets/icons/emailIcon.png'),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
                              child: const Divider(
                                color: kgreycolor1,
                                thickness: 1.5,
                                height: 0,
                              ),
                            ),
                            inputDesign(constraint, 'IC number', icNumcon,
                                'assets/icons/icNumberIcon.png'),
                            gaph(h: 17),
                            const Divider(
                              color: kgreycolor1,
                              thickness: 1.5,
                              height: 0,
                            ),

                            // Padding(
                            //   padding: EdgeInsets.only(top: 17.h),
                            //   child: Divider(
                            //     color: kgreycolor1,
                            //     thickness: 1.5,
                            //     height: 0,
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              gaph(h: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff16AA10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          fixedSize: Size(190.w, 70.h)),
                      onPressed: () async {
                        String fname = fullnamecon.text;
                        String phoneNum = phoneNumcon.text;
                        String email = emailcon.text;
                        String icNum = icNumcon.text;

                        if (fname.isNotEmpty &&
                            phoneNum.isNotEmpty &&
                            email.isNotEmpty &&
                            icNum.isNotEmpty) {
                          String longid = DateTime.now()
                              .microsecondsSinceEpoch
                              .toString(); //await nanoid(6);
                          String shortid = longid.substring(longid.length - 6);
                          Officer officer = Officer(
                            officerId: shortid,
                            name: fname,
                            phoneNum: phoneNum,
                            icNum: icNum,
                            email: email,
                            password: icNum,
                          );
                          dynamic result = await _auth
                              .registerOfficerWithEmailAndPaswordFunc(officer);

                          // if (result is User) {
                          //   await FirestoreDb(uid: result.uid)
                          //       .updateOfficerDataCollection(officer);
                          // } else
                          if (result is String) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result.toString())));
                          } else if (result is DocumentReference) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("register successful")));
                            Navigator.of(context).pop();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please fill all required field')));
                        }

                        //await FirestoreDb().addOfficerDataCollection(officer)
                        // await saveCar(driveruid, driverinfo, context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25.sp,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          fixedSize: Size(190.w, 70.h)),
                      onPressed: () async {
                        // carBrandcon.text = '';
                        // carPlateNumcon.text = '';
                        // carTypecon.text = '';
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25.sp,
                          color: const Color(0xffBEBEBE),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
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
              obscureText: (hintText == 'Password')
                  ? isHidden1
                  : hintText == 'Password Confirmation'
                      ? isHidden2
                      : false,
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
        hintText == "Password"
            ? SizedBox(
                width: 26,
                height: 26,
                child: IconButton(
                  iconSize: 26,
                  onPressed: () {
                    setState(() {
                      isHidden1 = !isHidden1;
                    });
                  },
                  icon: Icon(
                    isHidden1 ? Icons.visibility : Icons.visibility_off,
                    size: 26,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  splashRadius: 20,
                ),
              )
            : hintText == "Password Confirmation"
                ? SizedBox(
                    width: 26,
                    height: 26,
                    child: IconButton(
                      iconSize: 26,
                      onPressed: () {
                        setState(() {
                          isHidden2 = !isHidden2;
                        });
                      },
                      icon: Icon(
                        isHidden2 ? Icons.visibility : Icons.visibility_off,
                        size: 26,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      splashRadius: 20,
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
      ],
    );
  }

  AppBar registerOfficerAppbarDesign() {
    return AppBar(
      title: Text(
        'Register Officer Account',
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
