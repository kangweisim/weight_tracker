import 'package:weight_tracker/model.dart/app_variables.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/user.dart';

class SetUserAction {
  final String firstName;

  SetUserAction(this.firstName);
}

class AddWeightAction {
  final double weight;
  final DateTime date;

  AddWeightAction(this.weight, this.date);
}

class GetDataAction {}

class LoadedDataAction {
  final User user;
  final List<Day> days;
  final AppVariables appVariables;

  LoadedDataAction(this.user, this.days, this.appVariables);
}