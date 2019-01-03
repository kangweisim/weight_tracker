import 'package:weight_tracker/model.dart/app_variables.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:weight_tracker/model.dart/user.dart';
import 'package:redux/redux.dart';
import 'package:weight_tracker/model.dart/weight.dart';
import 'package:weight_tracker/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
      user: userReducer(state.user, action),
      days: dayReducer(state.days, action),
      appVariables: appVariablesReducer(state.appVariables, action));
}

Reducer<User> userReducer = combineReducers([
  TypedReducer<User, SetUserAction>(setUserReducer),
  TypedReducer<User, LoadedDataAction>(loadUserReducer)
]);

Reducer<List<Day>> dayReducer = combineReducers([
  TypedReducer<List<Day>, AddWeightAction>(addWeightReducer),
  TypedReducer<List<Day>, LoadedDataAction>(loadDaysReducer),
]);

Reducer<AppVariables> appVariablesReducer = combineReducers(
    [TypedReducer<AppVariables, LoadedDataAction>(loadAppVariablesReducer)]);

User setUserReducer(User user, SetUserAction action) {
  return User(firstName: action.firstName);
}

User loadUserReducer(User user, LoadedDataAction action) {
  return action.user;
}

List<Day> addWeightReducer(List<Day> days, AddWeightAction action) {
  if (days.length == 0 || (days.length > 0 && days[days.length - 1].date.difference(action.date).inDays != 0)) {
    return []
      ..addAll(days)
      ..add(Day(date: action.date, weights: [Weight(weight: action.weight)]));
  } else {
    Day lastDay = days[days.length - 1];
    List<Day> newDays = [];
    for (int i=0;i<days.length -1;i++) {
      newDays.add(days[i]);
    }
    List<Weight> lastDayWeights = []..addAll(lastDay.weights);
    lastDayWeights.add(Weight(weight: action.weight));
    newDays.add(lastDay.copyWith(weights: lastDayWeights));
    return newDays;
  }
  return []..addAll(days);
}

List<Day> loadDaysReducer(List<Day> items, LoadedDataAction action) {
  return action.days;
}

AppVariables loadAppVariablesReducer(
    AppVariables appVariables, LoadedDataAction action) {
  return action.appVariables.copyWith(hasLoaded: true);
}
