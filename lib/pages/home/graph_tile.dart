import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:weight_tracker/model.dart/day.dart';

class GraphTile extends StatelessWidget {
  final List<Day> days;
  List<double> avgDays;
  double low = 0;
  double high = 0;
  GraphTile({@required this.days}) {
    this.avgDays = days.map((day) {
      double sum = day.weights.fold(0, (a, b) => a + b.weight);
      double avg = sum / day.weights.length;
      if (low == 0) low = avg;
      if (avg > high) high = avg;
      return avg;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Low',
                                    style: TextStyle(color: Colors.redAccent)),
                                Text(low.toString() + 'kg',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('High',
                                    style: TextStyle(color: Colors.green)),
                                Text(high.toString() + 'kg',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0)),
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        Stack(
                          children: <Widget>[
                            Sparkline(
                              data: avgDays.length == 1 ? ([0]..addAll(avgDays)):avgDays,
                              lineWidth: 5.0,
                              lineColor: Colors.red,
                            )
                          ],
                        )
                      ],
                    )),);
  }
}
