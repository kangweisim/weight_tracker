import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:weight_tracker/pages/home/home_page.dart';
import 'package:weight_tracker/pages/setup/setup_page.dart';
import 'package:weight_tracker/redux/actions.dart';

class InitPage extends StatelessWidget {
  static final String route = "/";
  final double iconSize = 125.0;
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      onInit: (Store<AppState> store) => store.dispatch(GetDataAction()),
      onWillChange: (Store<AppState> store) {
        AppState state = store.state;
        if (state.appVariables.hasLoaded) {
          Timer(Duration(milliseconds: 500), () {
            Widget pageToPush = (state.user != null)
                ? HomePage()
                : SetupPage();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => pageToPush));
          });
        }
      },
      builder: (BuildContext context, Store<AppState> store) {
        return Scaffold(
            appBar: AppBar(
              title: Text("test"),
            ),
            drawer: Container(
              child: ReduxDevTools(store as DevToolsStore),
            ),
            body: Container(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                SpinKitDoubleBounce(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Icon(FontAwesomeIcons.weight,
                          color: Colors.blue.withOpacity(0.6), size: iconSize);
                    } else {
                      Container();
                    }
                  },
                  size: 200,
                ),
                Text("Loading...", style: TextStyle(fontFamily: 'Raleway', fontSize: 24, fontWeight: FontWeight.w600))
              ]),
            ));
      },
    );
  }
}
