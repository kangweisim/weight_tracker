import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:weight_tracker/model.dart/app_variables.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:weight_tracker/model.dart/user.dart';
import 'package:weight_tracker/pages/home/home_page.dart';
import 'package:weight_tracker/redux/actions.dart';

class SetupPage extends StatelessWidget {
  static final String route = "/setup";

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      return StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.create(store),
          builder: (BuildContext context, _ViewModel viewModel) => SafeArea(
                  child: Scaffold(
                appBar: AppBar(
                  title: Text("test"),
                ),
                resizeToAvoidBottomPadding: false,
                backgroundColor: Color(0xFFFFFFFF),
                body: Container(
                  child: Column(
                    children: <Widget>[
                      GradientAppBar('getfat'),
                      SetupWidget(viewModel),
                    ],
                  ),
                ),
                drawer: Container(child: ReduxDevTools(store as DevToolsStore)),
              )));
    });
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 106.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: barHeight + statusBarHeight,
      decoration: BoxDecoration(
        color: Color(0xFFBE90EC),
      ),
      child: Center(
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 36.0,
                fontFamily: 'Raleway')),
      ),
    );
  }
}

class SetupWidget extends StatefulWidget {
  final _ViewModel model;

  SetupWidget(this.model);

  @override
  _SetupWidgetState createState() => _SetupWidgetState();
}

class _SetupWidgetState extends State<SetupWidget> {
  TextEditingController _firstNameController;
  final _formKey = GlobalKey<FormState>();
  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _firstNameController.addListener(() {
      if (_firstNameController.text.isEmpty) {
        setState(() {
          buttonEnabled = false;
        });
      } else {
        setState(() {
          buttonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 20),
                child: Text(
                  "SETUP USER",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.0,
                      fontFamily: 'Raleway'),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a first name';
                        }
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'First Name',
                      ),
                    ),
                  )),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Text("Next"),
                      elevation: 4,
                      onPressed: (buttonEnabled)
                          ? () {
                              widget.model.setUser(_firstNameController.text);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          : null)
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        )
      ],
    ));
  }
}

class _ViewModel {
  final User user;
  final AppVariables appVariables;
  final Function(String) setUser;

  _ViewModel({this.user, this.appVariables, this.setUser});

  factory _ViewModel.create(Store<AppState> store) {
    _setUser(String firstName) {
      store.dispatch(SetUserAction(firstName));
    }

    return _ViewModel(
        user: store.state.user,
        appVariables: store.state.appVariables,
        setUser: _setUser);
  }
}
