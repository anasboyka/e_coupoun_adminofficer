import 'package:cloud_firestore/cloud_firestore.dart';

class Officer {
  final String? officerId;
  final String name;
  //final int age;
  final String phoneNum;
  final String icNum;
  final String email;
  final String password;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Officer({
    required this.name,
    //required this.age,
    required this.phoneNum,
    required this.icNum,
    required this.email,
    required this.password,
    this.officerId,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Officer.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Officer(
      name: map['name'],
      //age: map['age'],
      phoneNum: map['phoneNum'],
      icNum: map['icNum'],
      email: map['email'],
      password: map['password'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Officer.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Officer(
      name: map['name'],
      //age: map['age'],
      phoneNum: map['phoneNum'],
      icNum: map['icNum'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        //'age': age,
        'phoneNum': phoneNum,
        'icNum': icNum,
        'email': email,
        'password': password,
      };

  Officer copyWith({
    required String name,
    required int age,
    required String phoneNum,
    required String icNum,
    required String email,
  }) {
    return Officer(
      name: name,
      //age: age,
      phoneNum: phoneNum,
      icNum: icNum,
      email: email,
      password: password,
    );
  }

  @override
  String toString() {
    return '${name.toString()}, {age.toString()}, ${phoneNum.toString()}, ${icNum.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Officer && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
