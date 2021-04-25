import 'package:flutter/material.dart';
import 'package:vehicle_registration/screens/User.dart';
import 'package:vehicle_registration/screens/Vehicle_profile.dart';
import 'package:vehicle_registration/screens/appbar.dart';
import 'package:vehicle_registration/screens/database.dart';

class Transmission extends StatefulWidget {
  final String type;
  final String make;
  final String number;
  final String model;
  final String fuelType;
  const Transmission(
      {this.type, this.make, this.number, this.model, this.fuelType});
  @override
  _TransmissionState createState() => _TransmissionState();
}

class _TransmissionState extends State<Transmission> {
  var transmission = ["Manual", "Automatic"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Select Transmission Type"),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(transmission[index]),
              trailing: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                onPressed: () {
                  var newDBUser = User(
                      number: widget.number,
                      make: widget.make,
                      model: widget.model,
                      fuelType: widget.fuelType,
                      transmission: transmission[index]);
                  DatabaseHelper.db.newUser(newDBUser);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Profile(
                        number: widget.number,
                        make: widget.make,
                        model: widget.model,
                        fuelType: widget.fuelType,
                        trans: transmission[index],
                      );
                    }),
                  );
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
                color: Colors.purple,
                textColor: Colors.white,
                elevation: 5,
              ),
            );
          }),
    );
  }
}
