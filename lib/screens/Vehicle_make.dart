import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_registration/screens/Vehicle_model.dart';
import 'package:vehicle_registration/screens/appbar.dart';

class SelectMake extends StatefulWidget {
  final String type;
  final String number;
  const SelectMake({this.type, this.number});
  @override
  _SelectMakeState createState() => _SelectMakeState();
}

var vehicleType;

class _SelectMakeState extends State<SelectMake> {
  List make = List();
  Future<List<dynamic>> fetchlist() async {
    vehicleType = widget.type;
    final String apiUrl =
        "https://test.turbocare.app/turbo/care/v1/makes?class=" + vehicleType;

    var result = await http.get(apiUrl);
    make = jsonDecode(result.body);
    print(make[0]);
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
          future: fetchlist(),
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
                            title: Text(make[index]),
                            trailing: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SelectModel(
                                      number: widget.number,
                                      type: vehicleType,
                                      make: make[index],
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
