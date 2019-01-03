import 'package:flutter/foundation.dart';
import 'package:weight_tracker/model.dart/weight.dart';

class Day {
  final DateTime date;
  final List<Weight> weights;

  Day({@required this.date, this.weights});

  Day copyWith({DateTime date, List<Weight> weights}) {
    return Day(date: date ?? this.date, weights: weights ?? this.weights);
  }

  Day.fromJson(Map json)
      : date = DateTime.parse(json['date']),
        weights =
            (json['weights'] as List).map((i) => Weight.fromJson(i)).toList();

  Map toJson() => {'date': date.toIso8601String(), 'weights': weights};

  @override
  String toString() {
    return toJson().toString();
  }
}
