# 躲猫猫:cat:——Flutter[已支持移动端、Web]

> 一款适合年轻人的社交软件APP——躲猫猫
> 启用空安全：dart migrate --apply-changes
> 检查当前项目的依赖是否都满足空安全：对于可以空安全的版本，例如provider 5.0.0应当更新pubspec.yaml

## 开发环境
[√] Flutter (Channel stable, 2.2.0, on Microsoft Windows [Version 10.0.19042.985], locale zh-CN)
    • Flutter version 2.2.0 at D:\flutter
    • Framework revision b22742018b (11 days ago), 2021-05-14 19:12:57 -0700
    • Engine revision a9d88a4d18
    • Dart version 2.13.0
    • Pub download mirror https://pub.flutter-io.cn
    • Flutter download mirror https://storage.flutter-io.cn

[√] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
    • Android SDK at D:\AndroidSDK
    • Platform android-30, build-tools 30.0.3
    • ANDROID_HOME = D:\AndroidSDK
    • Java binary at: D:\Android Studio\jre\bin\java
    • Java version OpenJDK Runtime Environment (build 11.0.8+10-b944.6842174)
    • All Android licenses accepted.

[√] Chrome - develop for the web
    • Chrome at C:\Program Files (x86)\Google\Chrome\Application\chrome.exe

[√] Android Studio (version 4.1.0)
    • Android Studio at D:\Android Studio
    • Flutter plugin can be installed from:
       https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
       https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.8+10-b944.6842174)

[√] IntelliJ IDEA Ultimate Edition (version 2020.1)
    • IntelliJ at D:\IntelliJ IDEA\IntelliJ IDEA 2018.3.5
    • Flutter plugin can be installed from:
       https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
       https://plugins.jetbrains.com/plugin/6351-dart

[√] Connected device (3 available)
    • Android SDK built for x86 (mobile) • emulator-5554 • android-x86    • Android 10 (API 29) (emulator)
    • Chrome (web)                       • chrome        • web-javascript • Google Chrome 90.0.4430.72
    • Edge (web)                         • edge          • web-javascript • Microsoft Edge 90.0.818.66
    
### Flutter组件：https://flutter.dev/docs/reference/widgets

pdf打印：For the web, a javascript library and a small script has to be added to your web/index.html file, just before <script src="main.dart.js" type="application/javascript"></script>:
- FadeInImage
- InheritedModel
- LayoutBuilder
- AbsorbPointer
- Dismissible
- ValueListenableBuilder
- Draggable
- AnimatedList
- InheritedWidget
- Placeholder
- LimitedBox
- AnimatedSwitcher
- AnimatedPositioned
- AnimatedPadding
- Semantics
- AnimatedOpacity
- AnimatedCrossFade
- ColorFiltered
- ToggleButtons
- CupertinoActionSheet
- TweenAnimationBuilder
- SnackBar
- ListWheelScrollView
- ShaderMask
- NotificationListener
- ClipPath
- IgnorePointer
- CupertinoActivityIndicator
- CheckboxListTile
- SwitchListTile
- Location
- ImageFiltered
- PhysicalModel
- animation
- RotatedBox
- connectivity

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

## 错误上报
Sentry: https://sentry.io/welcome/

**如果可以，请动动手指，为我点个Star吧！感谢！:basketball_man:**

------

## Notes to Contributors

Fork hide_seek_cat

if you'd like to contribute back to the core, you can fork this repository and send me a pull request, when it is ready.

if you are new to Git or Github, please read the Github guide first.

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