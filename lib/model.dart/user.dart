import 'package:flutter/foundation.dart';

class User {
  final String firstName;

  User({
    @required this.firstName,
  });

  User copyWith({String firstName}) {
    return User(firstName: firstName ?? firstName);
  }

  User.fromJson(Map json): firstName = json['firstName'];

  Map toJson() => {
    'firstName': firstName
  };

  @override
  String toString() {
    return toJson().toString();
  }
}
