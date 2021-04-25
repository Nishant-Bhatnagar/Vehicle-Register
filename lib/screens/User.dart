import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String number;
  String make;
  String model;
  String fuelType;
  String transmission;

  User({this.number, this.make, this.model, this.fuelType, this.transmission});
  factory User.fromJson(Map<String, dynamic> json) => User(
      number: json["number"],
      make: json["make"],
      model: json["model"],
      fuelType: json["fuelType"],
      transmission: json["transmission"]);
  Map<String, dynamic> toJson() => {
        "number": number,
        "make": make,
        "model": model,
        "fuelType": fuelType,
        "transmission": transmission,
      };
}
