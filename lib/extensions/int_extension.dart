import '../common.dart';

extension IntExtension on int {
  double get pt => (minScreen / (isPad ? padDesignMinWidth : phoneDesignMinWidth)) * this;

  int get ptInt => pt.toInt();

  String get asStringTime => this < 10 ? "0$this" : "$this";
  String get asStringTimeSecond => "${(this~/60).asStringTime}:${(this%60).asStringTime}";

}
