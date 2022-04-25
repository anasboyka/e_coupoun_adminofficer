import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String name;
  final int age;
  final String phoneNum;
  final String icNum;
  final String email;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Admin({
    required this.name,
    required this.age,
    required this.phoneNum,
    required this.icNum,
    required this.email,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Admin.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return Admin(
      name: map['name'],
      age: map['age'],
      phoneNum: map['phoneNum'],
      icNum: map['icNum'],
      email: map['email'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      name: map['name'],
      age: map['age'],
      phoneNum: map['phoneNum'],
      icNum: map['icNum'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'age': age,
        'phoneNum': phoneNum,
        'icNum': icNum,
        'email': email,
      };

  Admin copyWith({
    required String name,
    required int age,
    required String phoneNum,
    required String icNum,
    required String email,
  }) {
    return Admin(
      name: name,
      age: age,
      phoneNum: phoneNum,
      icNum: icNum,
      email: email,
    );
  }

  @override
  String toString() {
    return '${name.toString()}, ${age.toString()}, ${phoneNum.toString()}, ${icNum.toString()}, ${email.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Admin && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
