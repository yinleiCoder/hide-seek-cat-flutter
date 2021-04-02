import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'zcoolcreator.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class ZcoolCreator {
  ZcoolCreator({this.id, this.username, this.avatar, this.pageUrl, this.signature, this.cityName, this.professionName, this.contentCountTips, this.popularityCountTips, this.fansCountTips, this.contentPageUrl});

  num id;
  String username;
  String avatar;
  String pageUrl;
  String signature;
  String cityName;
  String professionName;
  String contentCountTips;
  String popularityCountTips;
  String fansCountTips;
  String contentPageUrl;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ZcoolCreator.fromJson(Map<String, dynamic> json) => _$ZcoolCreatorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ZcoolCreatorToJson(this);
}