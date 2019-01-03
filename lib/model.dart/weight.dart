import 'package:flutter/foundation.dart';

class Weight {
  final double weight;

  Weight({@required this.weight});

  Weight.fromJson(Map json): weight = json['weight'];

  Map toJson() => {
    'weight': weight,
  };

  @override
  String toString() {
    return toJson().toString();
  }
}
