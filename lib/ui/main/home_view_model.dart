import 'dart:ffi';

import 'package:flutter_empty/models/index.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

/// 用法范例
/// 修改添加observable等需要执行 fvm dart run build_runner build 生效
abstract class HomeViewModelBase with Store {
  final demoList = ObservableList<Demo>();
  @observable
  int num = 0;

  /// action能保证方法内所有的修改完成通知一次UI更新，普通方法修改一个observable就会通知一次
  @action
  void numPlus() {
    num++;
    demoList.add(Demo(id: 0, name: "name $num", hasChild: false, values: List.empty()));
  }
}
