import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_registration/screens/appbar.dart';

import 'Vehicle_fueltype.dart';

class SelectModel extends StatefulWidget {
  final String type;
  final String make;
  final String number;
  const SelectModel({this.type, this.make, this.number});
  @override
  _SelectModelState createState() => _SelectModelState();
}

class _SelectModelState extends State<SelectModel> {
  List model = List();
  Future<List<dynamic>> fetchmodel() async {
    var vehicleType = widget.type;
    var vehicleMake = widget.make;
    final String apiUrl =
        "https://test.turbocare.app/turbo/care/v1/models?class=" +
            vehicleType +
            "&make=" +
            vehicleMake;
    var result = await http.get(apiUrl);
    model = jsonDecode(result.body);
    if (result.statusCode == 200 || result.statusCode < 400) {
      return json.decode(result.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Select Make"),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchmodel(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(model[index]),
                            trailing: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return FuelType(
                                        number: widget.number,
                                        type: widget.type,
                                        make: widget.make,
                                        model: model[index]);
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
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
