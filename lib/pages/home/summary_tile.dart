import 'package:flutter/material.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/user.dart';

class SummaryTile extends StatelessWidget {
  final Function onTap;
  final User user;
  final Day dayToday;

  SummaryTile(
      {@required this.onTap, @required this.user, @required this.dayToday});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(user != null ? user.firstName : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Raleway",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: dayToday == null
                              ? <Widget>[Text("No Record Today")]
                              : [
                                  Text(dayToday
                                      .weights[dayToday.weights.length - 1]
                                      .weight
                                      .toString() + "kg", style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600
                                      ),),
                                  Text("today", style: TextStyle(
                                    fontFamily: "Raleway"
                                  )),
                                ]),
                    )
                  ]),
            )));
  }
}
