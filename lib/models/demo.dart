import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class Demo {

  const Demo({
    required this.id,
    required this.name,
    required this.hasChild,
    this.likes,
    required this.values,
  });

  final int id;
  final String name;
  final bool hasChild;
  final List<String>? likes;
  final List<DemoValue> values;

  factory Demo.fromJson(Map<String,dynamic> json) => Demo(
    id: json['id'] as int,
    name: json['name'].toString(),
    hasChild: json['has_child'] as bool,
    likes: json['likes'] != null ? (json['likes'] as List? ?? []).map((e) => e as String).toList() : null,
    values: (json['values'] as List? ?? []).map((e) => DemoValue.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'has_child': hasChild,
    'likes': likes?.map((e) => e.toString()).toList(),
    'values': values.map((e) => e.toJson()).toList()
  };

  Demo clone() => Demo(
    id: id,
    name: name,
    hasChild: hasChild,
    likes: likes?.toList(),
    values: values.map((e) => e.clone()).toList()
  );


  Demo copyWith({
    int? id,
    String? name,
    bool? hasChild,
    Optional<List<String>?>? likes,
    List<DemoValue>? values
  }) => Demo(
    id: id ?? this.id,
    name: name ?? this.name,
    hasChild: hasChild ?? this.hasChild,
    likes: checkOptional(likes, () => this.likes),
    values: values ?? this.values,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Demo && id == other.id && name == other.name && hasChild == other.hasChild && likes == other.likes && values == other.values;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ hasChild.hashCode ^ likes.hashCode ^ values.hashCode;
}
