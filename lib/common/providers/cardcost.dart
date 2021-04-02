import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/storage.dart';
import 'package:flutter_hide_seek_cat/common/values/storage.dart';
/**
 * 开支助手provider
 * @author yinlei
*/
class CardProvider with ChangeNotifier {

  List<CardModel> cards = [];

  void initalState() {
    syncDataWithProvider();
  }

  void addCard(CardModel _card) {
    cards.add(_card);
    _updateSharedPrefrences();
    notifyListeners();
  }

  void removeCard(CardModel _card) {
    cards.removeWhere((card) => card.number == _card.number);
    _updateSharedPrefrences();
    notifyListeners();
  }

  int getCardLength() {
    return cards.length;
  }

  Future _updateSharedPrefrences() {
    List<String> mycards = cards.map((card) => json.encode(card.toJson())).toList();
    AppStorage().setStringList(STORAGE_USER_COST_KEY, mycards);
  }

  Future syncDataWithProvider() async {
    var result = AppStorage().getStringList(STORAGE_USER_COST_KEY);
    if(result != null) {
      cards = result.map((card) => CardModel.fromJson(json.decode(card))).toList();
    }
    notifyListeners();
  }

}