import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_registration/screens/Vehicle_make.dart';
import 'package:vehicle_registration/screens/appbar.dart';

class SelectClass extends StatefulWidget {
  final String number;

  const SelectClass({this.number});
  @override
  _SelectClassState createState() => _SelectClassState();
}

String dropdownValue = '2w';

class _SelectClassState extends State<SelectClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Select Vehicle Class"),
      body: ListView(
        children: <Widget>[
          Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['2w', '4w']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 570, 10, 0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SelectMake(
                        type: dropdownValue,
                        number: widget.number,
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
            ),
          )
        ],
      ),
    );
  }
}
