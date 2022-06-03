import 'package:e_coupoun_admin/model/compound.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/admin_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/compound_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/driver_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/location_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/officer_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/parking_list.dart';
import 'package:e_coupoun_admin/screen/homePage/admin_home/menu/subcompound/compound_detail.dart';
import 'package:e_coupoun_admin/screen/homePage/officer_home/officer_home_screen.dart';
import 'package:e_coupoun_admin/screen/homePage/officer_home/subpage/location_view_officer_page.dart';
import 'package:e_coupoun_admin/screen/homePage/officer_home/subpage/sublocation_selection/compound_history_page.dart';
import 'package:e_coupoun_admin/screen/homePage/officer_home/subpage/compound_page.dart';
import 'package:e_coupoun_admin/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => Wrapper());
      case '/officerLocationView':
        return CupertinoPageRoute(
          builder: (_) => LocationViewOfficerPage(
            locationParking: args as LocationParking,
          ),
        );
      case '/compound':
        return CupertinoPageRoute(
          builder: (_) => CompoundPage(
            argument: args as Map<String, dynamic>?,
          ),
        );
      case '/compoundhistory':
        return CupertinoPageRoute(builder: (_) => CompoundHistoryPage());
      //admin open
      case '/adminparkinglist':
        return CupertinoPageRoute(builder: (_) => ParkingList());
      case '/adminlocationlist':
        return CupertinoPageRoute(builder: (_) => LocationList());
      case '/admincompoundlist':
        return CupertinoPageRoute(builder: (_) => CompoundList());
      case '/admincompounddetail':
        return CupertinoPageRoute(
            builder: (_) => CompoundDetail(
                  compound: args as Compound,
                ));
      case '/adminadminlist':
        return CupertinoPageRoute(builder: (_) => AdminList());
      case '/adminofficerlist':
        return CupertinoPageRoute(builder: (_) => OfficerList());
      case '/admindriverlist':
        return CupertinoPageRoute(builder: (_) => DriverList());
      default:
        return CupertinoPageRoute(builder: (_) => OfficerHomeScreen());
    }
  }
}
