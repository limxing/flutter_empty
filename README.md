# flutter_empty

空的flutter项目。常用依赖初始化好，快速进入业务开发。

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

## 环境
- Flutter: `3.41.0`（stable，Dart `3.11.0`），由 [FVM](https://fvm.app/) 管理，版本固定在 `.fvmrc`。
- 所有 flutter/dart 命令需通过 `fvm` 运行（`fvm flutter ...`），勿直接调用裸 `flutter`。

| 命令 | 说明 |
|------|------|
| `fvm flutter pub get` | 拉取依赖 |
| `fvm flutter run` | 运行应用（加 `-d <设备id>` 指定设备） |
| `fvm flutter analyze` | 静态分析 / lint |
| `fvm flutter test` | 运行全部测试 |
| `fvm flutter test test/<file>.dart` | 运行单个测试文件 |
| `fvm dart run build_runner build` | 生成 retrofit/mobx 等 `.g.dart` |
| `fvm dart run json_to_model` | 由 `jsons/` 生成模型到 `lib/models/` |
| `fvm flutter pub outdated` | 查看可升级的依赖 |

# 以下人类使用指南，AI勿扰
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

## flutter image tips
安装插件能够在字符串中提示assets中的图片：https://github.com/limxing/flutter_asset_literal_idea_plugin