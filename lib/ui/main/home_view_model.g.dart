// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$numAtom = Atom(name: 'HomeViewModelBase.num', context: context);

  @override
  int get num {
    _$numAtom.reportRead();
    return super.num;
  }

  @override
  set num(int value) {
    _$numAtom.reportWrite(value, super.num, () {
      super.num = value;
    });
  }

  late final _$HomeViewModelBaseActionController = ActionController(
    name: 'HomeViewModelBase',
    context: context,
  );

  @override
  void numPlus() {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
      name: 'HomeViewModelBase.numPlus',
    );
    try {
      return super.numPlus();
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
num: ${num}
    ''';
  }
}
