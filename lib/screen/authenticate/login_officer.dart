import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/account.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPageOfficer extends StatefulWidget {
  const LoginPageOfficer({Key? key}) : super(key: key);

  @override
  _LoginPageOfficerState createState() => _LoginPageOfficerState();
}

class _LoginPageOfficerState extends State<LoginPageOfficer> {
  bool isHidden2 = true;
  bool isHidden1 = true;
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

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 18.h, 50.w, 44.h),
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
                            inputDesign(constraint, 'Email', loginEmailcon,
                                'assets/icons/officerIcon.png'),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 38.h),
                              child: Divider(
                                color: kgreycolor1,
                                thickness: 1.5,
                                height: 0,
                              ),
                            ),
                            inputDesign(constraint, 'Password', loginpasscon,
                                'assets/icons/passwordIcon.png'),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.h,
                      width: 210.w, //0.5 * size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff54A059),
                            Color(0xff40B74B),
                            Color(0xff2CD23C),
                            Color(0xff1EE332),
                            Color(0xff0BFD24),
                          ],
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 29,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onTap: () async {
                      print("login");
                      if (_formkey.currentState!.validate()) {
                        if (loginFormValidation()) {
                          setState(() => loading = true);
                          dynamic result = await AuthService()
                              .signInOfficerWithEmailAndPassword(
                                  loginEmailcon.text, loginpasscon.text);

                          //setState(() => loading = false);
                          print(result);
                          if (result is String) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(result)));
                            setState(() => loading = false);
                          }
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No User found')));
                            setState(() => loading = false);
                          }
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row inputDesign(BoxConstraints constraint, String hintText,
      TextEditingController controller, String assetImage) {
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

  createAlertDialog(BuildContext context, String inputData) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
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
                    'OK',
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
}
