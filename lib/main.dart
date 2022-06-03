import 'package:e_coupoun_admin/constant.dart';
import 'package:e_coupoun_admin/model/account.dart';
import 'package:e_coupoun_admin/model/auth_id.dart';
import 'package:e_coupoun_admin/route_generator.dart';
import 'package:e_coupoun_admin/services/firebase_authentication/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthId?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null),
      ],
      child: ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: kprimarySwatch,
              ),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }),
    );
  }
}
