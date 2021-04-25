import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_registration/screens/Vehicle_selection.dart';
import 'package:vehicle_registration/screens/appbar.dart';

class VehicleNumber extends StatefulWidget {
  @override
  _VehicleNumberState createState() => _VehicleNumberState();
}

class _VehicleNumberState extends State<VehicleNumber> {
  TextEditingController myController = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Create new vehicle profile"),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: new TextFormField(
              controller: myController,
              decoration: new InputDecoration(
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                labelText: "Enter Vehicle Number",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Number cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
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
                  setState(() {
                    myController.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                  if (myController.text.isEmpty) {
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SelectClass(
                          number: myController.text,
                        );
                      }),
                    );
                  }
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
