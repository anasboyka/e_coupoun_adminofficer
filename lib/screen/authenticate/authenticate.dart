import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/screen/authenticate/login_officer.dart';
import 'package:e_coupoun_admin/screen/authenticate/login_admin.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  int currentIndex = 0;
  int animatedpos = 0;

  bool togglePlaces = true;
  bool isHidden2 = true;
  bool isHidden1 = true;
  bool animationEnd = true;
  bool valSwitch = true;
  bool loading = false;

  final usernamecon = TextEditingController();
  final namecon = TextEditingController();
  final phoneNumcon = TextEditingController();
  final emailcon = TextEditingController();
  final passcon = TextEditingController();
  final confirmpasscon = TextEditingController();
  final icNumcon = TextEditingController();
  final dateOfBirthcon = TextEditingController();
  final loginEmailcon = TextEditingController();
  final loginpasscon = TextEditingController();

  final pagecon = PageController(initialPage: 0);

  String //username = "",
      //name = "",
      phoneNum = "",
      email = "",
      pass = "",
      confirmPass = "",
      //icNum = "",
      //dateOfBirth = "",
      error = "error";

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  DateTime? _date;
  createAlertDialog(BuildContext context, String inputData) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'E-Coupoun Parking',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Please enter $inputData',
              style: const TextStyle(
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
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  //Navigator.of(context).pop("data from dialog");
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43, 9, 15),
            buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            contentPadding: EdgeInsets.fromLTRB(27, 20, 15, 0),
            insetPadding: EdgeInsets.fromLTRB(55, 0, 55, 0),
            titlePadding: EdgeInsets.fromLTRB(27, 27, 27, 0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            //shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.05 * size.height),
                child: Image.asset(
                  'assets/icons/logo1.png',
                  height: 185,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 0),
                child: Container(
                  //alignment: Alignment.center,
                  height: 60,
                  //width: 0.77 * size.width,
                  //padding: EdgeInsets.only(top: 0.02 * size.height),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        kdarkGreen,
                        kdarkMediumGreen,
                        kmediumGreen,
                        kmediumlightGreen,
                        klightGreen,
                      ],
                    ),
                  ),
                  child:
                      //     CustomSlidingSegmentedControl(
                      //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   //fromMax: true,
                      //   duration: Duration(milliseconds: 300),
                      //   height: 60.h,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         kdarkGreen,
                      //         kdarkMediumGreen,
                      //         kmediumGreen,
                      //         kmediumlightGreen,
                      //         klightGreen,
                      //       ],
                      //     ),
                      //   ),
                      //   thumbDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(40),
                      //       color: Colors.white),
                      //   isStretch: true,
                      //   //fixedWidth: double.infinity,
                      //   padding: 0,
                      //   innerPadding: 4,
                      //   //duration: Duration(milliseconds: 200),
                      //   //highlightColor: Colors.black,
                      //   //height: 60,
                      //   //padding: 0,

                      //   // backgroundColor: Colors.transparent,
                      //   // padding: EdgeInsets.all(4),
                      //   // groupValue: currentIndex,
                      //   children: {
                      //     0: buildSegment('Login'),
                      //     1: buildSegment('New User'),
                      //   },
                      //   onValueChanged: (groupValue) {
                      //     setState(() {
                      //       currentIndex = groupValue as int;
                      //     });
                      //   },
                      // )
                      LayoutBuilder(
                    builder: (context, constraint) {
                      double gap = 1 / 6 / 2 * constraint.maxHeight;
                      double toRight =
                          constraint.maxWidth - (0.5 * constraint.maxWidth);
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            left: togglePlaces ? gap : toRight,
                            top: gap,
                            child: Container(
                              alignment: Alignment.center,
                              height: 5 / 6 * constraint.maxHeight,
                              width: (0.5 * constraint.maxWidth) - gap,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            left: gap,
                            top: gap,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 5 / 6 * constraint.maxHeight,
                                width: (0.5 * constraint.maxWidth) - gap,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Officer',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 19,
                                    color: animatedpos == 0
                                        ? animationEnd
                                            ? togglePlaces
                                                ? Colors.black
                                                : Colors.white
                                            : Colors.black
                                        : animationEnd
                                            ? togglePlaces
                                                ? Colors.black
                                                : Colors.white
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              onTap: () async {
                                pagecon.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                                setState(() {
                                  animationEnd = false;
                                  if (!togglePlaces) {
                                    togglePlaces = !togglePlaces;
                                  }
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 250));
                                setState(() {
                                  animationEnd = true;
                                  animatedpos = 0;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            right: gap,
                            top: gap,
                            child: InkWell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 5 / 6 * constraint.maxHeight,
                                  width: (0.5 * constraint.maxWidth) - gap,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    'Admin',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 19,
                                        color: animatedpos == 0
                                            ? animationEnd
                                                ? togglePlaces
                                                    ? Colors.white
                                                    : Colors.black
                                                : Colors.white
                                            : animationEnd
                                                ? togglePlaces
                                                    ? Colors.white
                                                    : Colors.black
                                                : Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              onTap: () async {
                                pagecon.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                                setState(() {
                                  if (togglePlaces) {
                                    togglePlaces = !togglePlaces;
                                  }
                                  animationEnd = false;
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 250));
                                setState(() {
                                  animationEnd = true;
                                  animatedpos = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: pagecon,
                  children: const [
                    LoginPageOfficer(),
                    LoginPageAdmin(),
                    //loginInputDesign(size),
                    //registerInputDesign(size),
                  ],
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSegment(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 19,
        //color:
      ),
    );
  }

  // void registerUser() async {
  //   print("register");
  //   if (_formkey.currentState!.validate()) {
  //     if (registerFormValidation()) {
  //       setState(() => loading = true);
  //       print("start firebase");
  //       print(emailcon.text);
  //       print(passcon.text);
  //       dynamic result = await _auth.
  //       if (result == null) {
  //         setState(() => error = "please supply a valid email");
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('$error')),
  //         );
  //         setState(() => loading = false);
  //       } else if (result == 'emailUsed') {
  //         setState(() => error = "Email is already in used");
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('$error')),
  //         );
  //         setState(() => loading = false);
  //       } else if (result == 'passwordweak') {
  //         setState(() => error = "Password is to weak");
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('$error')),
  //         );
  //         setState(() => loading = false);
  //       }
  //       print(error);
  //     }
  //   }
  // }

  bool registerFormValidation() {
    // if (usernamecon.text.isEmpty) {
    //   createAlertDialog(context, "Username");
    //   return false;
    // }
    // if (namecon.text.isEmpty) {
    //   createAlertDialog(context, "name");
    //   return false;
    // }
    if (phoneNumcon.text.isEmpty) {
      createAlertDialog(context, "Phone number");
      return false;
    }
    if (emailcon.text.isEmpty) {
      createAlertDialog(context, "E-mail adrress");
      return false;
    }
    if (passcon.text.isEmpty) {
      createAlertDialog(context, "Password");
      return false;
    }
    if (confirmpasscon.text.isEmpty) {
      createAlertDialog(context, "Password Confirmation");
      return false;
    }
    // if (icNumcon.text.isEmpty) {
    //   createAlertDialog(context, "IC number");
    //   return false;
    // }
    // if (dateOfBirthcon.text.isEmpty) {
    //   createAlertDialog(context, "Date of birth");
    //   return false;
    // }
    if (passcon.text.length < 6) {
      createAlertDialog(context, "Password more than 6 character");
      return false;
    }
    if (passcon.text != confirmpasscon.text) {
      createAlertDialog(context, "Matched password");
      return false;
    }
    return true;
  }

  bool loginFormValidation() {
    if (loginEmailcon.text.isEmpty) {
      createAlertDialog(context, "Username/email");
      return false;
    }
    if (loginpasscon.text.isEmpty) {
      createAlertDialog(context, "Password");
      return false;
    }
    return true;
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
}
