import 'package:flutter/foundation.dart';
import 'package:weight_tracker/model.dart/app_variables.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/user.dart';

class AppState {
  final User user;
  final List<Day> days;
  final AppVariables appVariables;

  const AppState({@required this.user, @required this.days, @required this.appVariables});

  AppState.initialState()
      : user = null,
        days = [],
        appVariables = AppVariables();

  AppState.fromJson(Map json)
      : user = User.fromJson(json['user']),
        days = (json['days'] as List).map((i) => Day.fromJson(i)).toList(),
        appVariables = AppVariables.fromJson(json['appVariables']);

  Map toJson() => {'user': user, 'days': days, 'appVariables': appVariables};

  @override
  String toString() {
    return toJson().toString();
  }
}
