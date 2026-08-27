# flutter_empty

空的flutter项目。常用依赖初始化好，快速进入进入业务开发。

## AI注意
- 保持当前代码书写风格
- 不要修改依赖的库源码
- 依赖库升级先找源头的依赖库进行升级
- 仅关注业务代码
- 网络问题，让人类介入
- 注意内存管理，避免内存泄露
- 生成的类、方法和方法中的过程等添加注释
- 不要删除已有的注释
- 使用fvm管理

## Android Studio 代码模板：MobX ViewModel

1. `Settings` → `Editor` → `Live Templates` → `+` → `Live Template`，`Abbreviation` 填 `vm`。
2. `Template text` 填：

```dart
import 'package:mobx/mobx.dart';

part '$file$_view_model.g.dart';

class $ClassName$ViewModel = $ClassName$ViewModelBase with _$$$ClassName$ViewModel;

abstract class $ClassName$ViewModelBase with Store {

}
```

3. 点 `Define` → 勾选 `Dart`。
4. 点 `Edit variables`：

   | 变量 | Expression | Default | Skip if defined |
   |------|-----------|---------|-----------------|
   | `ClassName` | (空) | `Home` | 否 |
   | `file` | `camelCase(ClassName)` | (空) | 是 |

5. 使用：`.dart` 文件输入 `vm` + `Tab`，展开后输入类名（如 `Login`）即批量替换所有位置。

> 注意：字面 `$` 用 `$$` 转义，变量用 `$名字$`。`_$$$ClassName$ViewModel` 解析为 `_` + 字面`$` + 变量`ClassName` + `ViewModel` → `_$LoginViewModel`。
