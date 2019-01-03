import 'package:flutter/material.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/user.dart';

class InputTile extends StatefulWidget {
  final User user;
  final Day dayToday;
  final Function onTap;

  InputTile(
      {@required this.user, @required this.dayToday, @required this.onTap});

  @override
  _InputTileState createState() => _InputTileState();
}

class _InputTileState extends State<InputTile> {
  TextEditingController _weightController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _weightController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter weight';
                              }
                            },
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Today's weight",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                            elevation: 4,
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(24.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24.0),
                              onTap: () {
                                double weight = 0.0;
                                try {
                                  weight = double.parse(_weightController.text);
                                } catch(e) {
                                  weight = 0;
                                }
                                if (weight > 0) {
                                  widget.onTap(weight);
                                }
                                
                              },
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.check,
                                    color: Colors.white, size: 20.0),
                              )),
                            ))
                      ]),
                )
              ]),
        )));
  }
}
