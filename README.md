# 躲猫猫:cat:——Flutter 移动端

> 一款适合年轻人的社交软件APP——躲猫猫
> 现已支持Flutter Web 并 支持空安全
> 启用空安全：dart migrate --apply-changes
> 检查当前项目的依赖是否都满足空安全：对于可以空安全的版本，例如provider 5.0.0应当更新pubspec.yaml

## 开发环境

- Flutter 2.0.0 • channel beta • https://github.com/flutter/flutter.git
- Framework • revision 60bd88df91 (21 hours ago) • 2021-03-03 09:13:17 -0800
- Engine • revision 40441def69
- Tools • Dart 2.12.0
- AndroidStudio：4.1.2
- Android Emulators:  Android R(Pixel 4)

### 参考Material Design，APP中所有使用的Flutter 组件均可在https://flutter.cn/中找到，包括：

- SafeArea —— used
- Expanded —— used
- Wrap —— used
- AnimatedContainer —— used
- Opacity —— used
- FutureBuilder
- FadeTransition —— used
- FloatingActionButton —— used
- PageView —— used
- Table —— used
- SliverAppBar
- SliverList
- SliverGrid
- FadeInImage
- StreamBuilder
- InheritedModel
- ClipRRect —— used
- CustomPaint
- Hero
- Tooltip
- FittedBox
- LayoutBuilder —— used
- AbsorbPointer
- Transform —— used
- ImageFilter
- BackdropFilter
- Align —— used
- Positioned —— used
- AnimatedBuilder —— used
- Dismissible
- SizedBox —— used
- ValueListenableBuilder
- Draggable
- AnimatedList
- Stack —— used
- Flexible —— used
- MediaQuery —— used
- Spacer —— used
- InheritedWidget
- AnimatedIcon —— used
- AspectRatio —— used
- Placeholder
- LimitedBox
- ReorderableListView
- RichText —— used
- AnimatedSwitcher
- AnimatedPositioned
- AnimatedPadding
- IndexedStack
- Semantics
- ConstrainedBox
- AnimatedOpacity
- FractionallySizedBox —— used
- ListView —— used
- ListTitle —— used
- Container —— used
- SelectableText
- DataTable —— used
- Slider
- AlertDialog —— used
- AnimatedCrossFade
- DraggableScrollableSheet
- ColorFiltered —— used
- ToggleButtons
- CupertinoActionSheet
- TweenAnimationBuilder
- Image —— used
- TabBar —— used
- DefaultTabController —— used
- Drawer —— used
- SnackBar
- ListWheelScrollView
- ShaderMask
- NotificationListener
- Builder —— used
- ClipPath
- CircularProgressIndicator
- LinearProgressIndicator
- Divider —— used
- IgnorePointer
- CupertinoActivityIndicator
- ClipOval —— used
- AnimatedWidget —— used
- Padding —— used
- CheckboxListTile
- AboutDialog —— used
- InteractiveViewer
- GridView
- SwitchListTile
- Location
- ....

------
## WebView

- WebView与原生的混合
- 计算Web页面高度
- 拦截请求、自定义指令
- 内存占用(尽量少的DOM元素)

## JSON序列化

采用了官方给的方式。
flutter pub run build_runner watch
```dart
/// Tell json_serializable that "registration_date_millis" should be
/// mapped to this property.
@JsonKey(name: 'registration_date_millis')
final int registrationDateMillis;

/// Tell json_serializable to use "defaultValue" if the JSON doesn't
/// contain this key or if the value is `null`.
@JsonKey(defaultValue: false)
final bool isAdult;

/// When `true` tell json_serializable that JSON must contain the key, 
/// If the key doesn't exist, an exception is thrown.
@JsonKey(required: true)
final String id;

/// When `true` tell json_serializable that generated code should 
/// ignore this field completely. 
@JsonKey(ignore: true)
final String verificationCode;

/// 对于嵌套类的JSON序列
// To make this work, pass explicitToJson: true in the @JsonSerializable() annotation over the class declaration. The User class now looks as follows:
import 'address.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String firstName;
  Address address;

  User(this.firstName, this.address);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

```

## dio文件上传和表单提交
```dart
/// Using application/x-www-form-urlencoded format
/// By default, Dio serializes request data(except String type) to JSON. To send data in the application/x-www-form-urlencoded format instead, you can :
//Instance level
dio.options.contentType = Headers.formUrlEncodedContentType;
//or works once
dio.post("/info", data:{"id":5}, 
         options: Options(contentType:Headers.formUrlEncodedContentType ));

/// 1. Sending FormData
// You can also send FormData with Dio, which will send data in the multipart/form-data, and it supports uploading files.
FormData formData = FormData.from({
    "name": "wendux",
    "age": 25,
    "file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt")
});
response = await dio.post("/info", data: formData);

/// 2. Multiple files upload 
// There are two ways to add multiple files to FormData， the only difference is that upload keys are different for array types。
// The upload key eventually becomes "files[]"，This is because many back-end services add a middle bracket to key when they get an array of files. If you don't want “[]”，you should create FormData as follows（Don't use FormData.fromMap）:
  var formData = FormData();
  formData.files.addAll([
    MapEntry(
      "files",
       MultipartFile.fromFileSync("./example/upload.txt",
          filename: "upload.txt"),
    ),
    MapEntry(
      "files",
      MultipartFile.fromFileSync("./example/upload.txt",
          filename: "upload.txt"),
    ),
  ]);


```

## 程序图标

制作：https://www.designevo.com/logo-maker/

参考Android和iOS的最大尺寸[1024*1024]

然后FlutterLaunchIcons:https://pub.dev/packages/flutter_launcher_icons

## 启动图

制作：https://www.canva.cn/design/DAEZRss1im4/MReV8kx4yCpmmJpLMtf9QQ/edit

在线生成不同的图片格式：https://hotpot.ai/icon-resizer?s=sidebar

然后将android/res/下的相关图片覆盖并修改drawable配置即可。

## 程序名称

android下的清单文件下改label

## 生成证书

AS可GUI操作，

如果命令操作,进入app输入如下命令：

```js
keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

将在android/app/下生成key.jks

然后android下新建key.properties编写配置。

最后修改android/app/build.gradle配置即可。

【上述语法需要gradle知识】

## 混淆

android/gradle.properties添加：

```js
extra-gen-snapshot-options=--obfuscate
```

修改build相关release配置即可。

## 编译打包

```js
flutter build apk --split-per-abi
```

打出的v8兼容v7,对外发布一般用v7包，x86是模拟器

**如果可以，请动动手指，为我点个Star吧！感谢！:basketball_man:**

------



## License
MIT License

Copyright (c) 2021 YinLei

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.