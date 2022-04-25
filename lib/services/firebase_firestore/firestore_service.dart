import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_admin/model/car.dart';
import 'package:e_coupoun_admin/model/compound.dart';
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

  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  final CollectionReference locationParkCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference parkingCollection =
      FirebaseFirestore.instance.collection('parkings');

  final CollectionReference compoundCollection =
      FirebaseFirestore.instance.collection('compounds');

  Future updateOfficerDataCollection(Officer officer) async {
    return await officerCollection.doc(uid).set(officer.toMap());
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Car.fromFirestore(doc);
    }).toList();
  }

  List<LocationParking> _locationListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return LocationParking.fromFirestore(doc);
    }).toList();
  }

  List<Parking> _parkingListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return Parking.fromFirestore(doc);
    }).toList();
  }

  List<Compound> _compoundListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Compound.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Compound>> streamCarCompoundListById(String carPlateNum) {
    return compoundCollection
        .where('carId', isEqualTo: carPlateNum)
        .orderBy('dateIssued', descending: true)
        .snapshots()
        .map(_compoundListFromSnapshot);
  }

  Stream<List<Car>> streamCurrentParkingCar() {
    return carCollection
        .where('parkingStatus', isEqualTo: true)
        .orderBy('carPlateNum', descending: true)
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Stream<Car?> getCarById(String id) {
    return carCollection.doc(id).snapshots().map((doc) {
      return Car.fromFirestore(doc);
    });
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

  Future updateCompoundDataCollection(Compound compound) async {
    return await compoundCollection.doc(uid).set(compound.toMap());
  }
}
