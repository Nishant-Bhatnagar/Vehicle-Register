import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_registration/screens/User.dart';
import 'package:vehicle_registration/screens/Vehicle_number.dart';
import 'package:vehicle_registration/screens/Vehicle_profile.dart';
import 'package:vehicle_registration/screens/appbar.dart';
import 'package:vehicle_registration/screens/database.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  Map<dynamic, dynamic> newUser = {};
  Future _userFuture;
  List items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.db.getUser().then((value) {
      setState(() {
        value.forEach((a) {
          items.add(User.fromJson(a));
        });
      });
    });
    _userFuture = getUser();
  }

  var userdata;
  getUser() async {
    userdata = await DatabaseHelper.db.getUser();
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    if (userdata != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: appBar("Vehicles List"),
          body: Center(
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: [
                      Divider(height: 5.0),
                      ListTile(
                        title: Text('${items[position].number}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                            )),
                        subtitle: Text(
                          '${items[position].make}' +
                              '  '
                                  '${items[position].model}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        trailing: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Profile(
                                  number: items[position].number,
                                  make: items[position].make,
                                  model: items[position].model,
                                  fuelType: items[position].fuelType,
                                  trans: items[position].transmission,
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
                    ],
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return VehicleNumber();
                  }),
                );
              }),
        ),
      );
    }
    return Scaffold(
      appBar: appBar("Vehicle List"),
      body: ListView(
        children: <Widget>[
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
                      return VehicleNumber();
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
