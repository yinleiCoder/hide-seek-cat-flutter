# 躲猫猫:cat:——Flutter 移动端

> 一款适合年轻人的社交软件APP——躲猫猫
>

## 开发环境

- Dart SDK：2.12.0-133.7.beta
- Flutter：1.25.0-8.3.pre 
- AndroidStudio：4.1.2
- Android Emulators:  Android R(Pixel 4)
- 

### 本项目遵循的Material Design，APP中所有使用的Flutter 组件均可在https://flutter.cn/中找到，包括：

- SafeArea —— used
- Expanded —— used
- Wrap
- AnimatedContainer —— used
- Opacity —— used
- FutureBuilder
- FadeTransition —— used
- FloatingActionButton —— used
- PageView —— used
- Table
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
- Spacer
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
- DataTable
- Slider
- AlertDialog
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

------

本项目为前后端分离APP，涉及多个端的开发(Android、iOS、QT、Web、CMS、微信小程序等)

其中，采用WebRTC、Tensorflow、Ffmpeg、Docker、CI/CD来强化APP功能。

”**躲猫猫“多端源码均可在我的仓库中找到：https://github.com/yinleiCoder**

**编码不易，如果可以，请动动手指，为我点个Star吧！感谢！:basketball_man:**

------



## License

**躲猫猫** is MIT licensed.