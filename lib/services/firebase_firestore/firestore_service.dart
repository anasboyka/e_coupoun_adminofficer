import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_admin/model/admin.dart';
import 'package:e_coupoun_admin/model/car.dart';
import 'package:e_coupoun_admin/model/compound.dart';
import 'package:e_coupoun_admin/model/driver.dart';
import 'package:e_coupoun_admin/model/location_parking.dart';
import 'package:e_coupoun_admin/model/officer.dart';
import 'package:e_coupoun_admin/model/parking.dart';

class FirestoreDb {
  final String? uid;
  FirestoreDb({this.uid});

  final CollectionReference officerCollection =
      FirebaseFirestore.instance.collection('officers');

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admins');

  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');

  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  final CollectionReference locationParkCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference parkingCollection =
      FirebaseFirestore.instance.collection('parkings');

  final CollectionReference compoundCollection =
      FirebaseFirestore.instance.collection('compounds');

  //officer open
  Stream<Officer> get officer {
    return officerCollection
        .doc(uid)
        .snapshots()
        .map((doc) => Officer.fromFirestore(doc));
  }

  List<Officer> _officerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Officer.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Officer>> get officers {
    return officerCollection.snapshots().map(_officerListFromSnapshot);
  }

  Future updateOfficerDataCollection(Officer officer) async {
    return await officerCollection
        .doc(officer.documentID)
        .update(officer.toMap());
  }

  Future addOfficerDataCollection(Officer officer) async {
    return await officerCollection.add(officer.toMap());
  }

  Future<bool> accountIsOfficer(String email) async {
    var ref = await officerCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs);
    if (ref.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteOfficer(Officer officer) async {
    return await officerCollection.doc(officer.documentID).delete();
  }
  //officer closed

  //admin open
  Stream<Admin> get admin {
    return adminCollection
        .doc(uid)
        .snapshots()
        .map((doc) => Admin.fromFirestore(doc));
  }

  List<Admin> _adminListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Admin.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Admin>> get admins {
    return adminCollection.snapshots().map(_adminListFromSnapshot);
  }

  Future updateAdminDataCollection(Admin admin) async {
    return await adminCollection.doc(uid).set(admin.toMap());
  }

  Stream<bool> accountIsAdminStream() {
    return adminCollection.doc(uid).snapshots().map((event) => event.exists);
  }

  Future<bool> accountIsAdmin(String email) async {
    var ref = await adminCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs);
    if (ref.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //admin closed

  //driver open
  List<Driver> _driverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Driver.fromFirestore(doc);
    }).toList();
  }

  Stream<Driver?> get driver {
    return driverCollection.doc(uid).snapshots().map((doc) {
      return Driver.fromFirestore(doc);
    });
  }

  Stream<List<Driver>> get drivers {
    return driverCollection.snapshots().map(_driverListFromSnapshot);
  }

  Future<Driver?> get driverinfo async {
    return await driverCollection
        .doc(uid)
        .get()
        .then((data) => Driver.fromFirestore(data));
  }

  Future deleteDriver(Driver driver) async {
    return await driverCollection.doc(driver.documentID).delete();
  }

  //driver closed

  //Car open
  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Car.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Car>> streamCurrentParkingCar() {
    return carCollection
        .where('parkingStatus', isEqualTo: true)
        .orderBy('carPlateNum', descending: true)
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Stream<List<Car>> streamCurrentParkingCarByLocationId(String locationId) {
    return carCollection
        .where('parkingStatus', isEqualTo: true)
        .where('locationId', isEqualTo: locationId)
        .orderBy('carPlateNum', descending: false)
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Stream<Car?> getCarById(String id) {
    return carCollection.doc(id).snapshots().map((doc) {
      return Car.fromFirestore(doc);
    });
  }
  //car closed

  //locationParking open
  List<LocationParking> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return LocationParking.fromFirestore(doc);
    }).toList();
  }

  Stream<List<LocationParking>> get locations {
    return locationParkCollection.snapshots().map(_locationListFromSnapshot);
  }

  Future addLocation(LocationParking locationParking) async {
    return locationParkCollection.add(locationParking.toMap());
  }

  //locationParking closed
  //parking open
  List<Parking> _parkingListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return Parking.fromFirestore(doc);
    }).toList();
  }

  //parking closed
  //compound open
  List<Compound> _compoundListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Compound.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Compound>> get compounds {
    return compoundCollection
        .orderBy('dateIssued', descending: true)
        .snapshots()
        .map(_compoundListFromSnapshot);
  }

  Stream<List<Compound>> streamCarCompoundListByCarPlateNum(
      String carPlateNum) {
    return compoundCollection
        .where('carId', isEqualTo: carPlateNum)
        .orderBy('dateIssued', descending: true)
        .snapshots()
        .map(_compoundListFromSnapshot);
  }

  Stream<List<Compound>> streamCarCompoundListByOfficerId() {
    return compoundCollection
        .where('officerId', isEqualTo: uid)
        .orderBy('dateIssued', descending: true)
        .snapshots()
        .map(_compoundListFromSnapshot);
  }

  Future updateCompoundDataCollection(Compound compound) async {
    return await compoundCollection.doc(uid).set(compound.toMap());
  }

  Future deleteCompoundById(String compoundId) async {
    return compoundCollection.doc(compoundId).delete();
  }

  //compound closed

}
