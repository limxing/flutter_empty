import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class DemoValue {

  const DemoValue({
    required this.id,
    required this.value,
  });

  final int id;
  final String value;

  factory DemoValue.fromJson(Map<String,dynamic> json) => DemoValue(
    id: json['id'] as int,
    value: json['value'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value
  };

  DemoValue clone() => DemoValue(
    id: id,
    value: value
  );


  DemoValue copyWith({
    int? id,
    String? value
  }) => DemoValue(
    id: id ?? this.id,
    value: value ?? this.value,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is DemoValue && id == other.id && value == other.value;

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
