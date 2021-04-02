import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'zcoolsearch.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class ZcoolSearch {
  ZcoolSearch({this.id, this.cover, this.title, this.cateStr, this.subCateStr, this.publishTimeDiffStr, this.viewCountStr, this.recommendCountStr, this.creatorObj});

  num id;
  String cover;
  String title;
  String cateStr;
  String subCateStr;
  String publishTimeDiffStr;
  String viewCountStr;
  String recommendCountStr;
  ZcoolCreator creatorObj;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ZcoolSearch.fromJson(Map<String, dynamic> json) => _$ZcoolSearchFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ZcoolSearchToJson(this);
}