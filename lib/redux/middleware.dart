import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:weight_tracker/redux/actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> appStateMiddleware([AppState state = const AppState(
  user: null,
  days: [],
  appVariables: null
)]) {
  final loadData = _loadFromPrefs(state);
  final saveData = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, SetUserAction>(saveData),
    TypedMiddleware<AppState, AddWeightAction>(saveData),
    TypedMiddleware<AppState, GetDataAction>(loadData)
  ];
}

Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    AppState state = await loadFromPrefs();
    store.dispatch(LoadedDataAction(state.user, state.days, state.appVariables));
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('state', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('state');
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}