import 'package:flutter/material.dart';
import 'package:vehicle_registration/screens/Vehicle_transmission.dart';
import 'package:vehicle_registration/screens/appbar.dart';

class FuelType extends StatefulWidget {
  final String type;
  final String make;
  final String number;
  final String model;
  const FuelType({this.type, this.make,this.number,this.model});
  @override
  _FuelTypeState createState() => _FuelTypeState();
}

class _FuelTypeState extends State<FuelType> {
  var fueltype = ["petrol", "diesel"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Select Fuel Type"),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(fueltype[index]),
              trailing: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Transmission(
                          number: widget.number,
                          type: widget.type,
                          make: widget.make,
                          model:widget.model,
                        fuelType: fueltype[index],
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
