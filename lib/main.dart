import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:weight_tracker/pages/init/init_page.dart';
import 'package:weight_tracker/redux/middleware.dart';
import 'package:weight_tracker/redux/reducers.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final DevToolsStore<AppState> store = DevToolsStore<AppState>(appStateReducer,
      initialState: AppState.initialState(), middleware: appStateMiddleware());

  @override
  Widget build(BuildContext context) {

    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Wedding Planner",
          initialRoute: InitPage.route,
          routes: {
            InitPage.route: (context) => InitPage(),
          },
        ));
  }
}