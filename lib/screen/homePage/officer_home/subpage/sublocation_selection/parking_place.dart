import 'package:flutter/material.dart';

class ParkingPlace extends StatefulWidget {
  const ParkingPlace({Key? key}) : super(key: key);

  @override
  _ParkingPlaceState createState() => _ParkingPlaceState();
}

class _ParkingPlaceState extends State<ParkingPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Place'),
      ),
      body: Container(),
    );
  }
}
