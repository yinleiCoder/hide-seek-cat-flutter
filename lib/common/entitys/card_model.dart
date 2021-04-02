/**
 * 账单助手
 * 银行卡信息
 * @author yinlei
*/
class CardModel {
  final int id;
  final String name;
  final String bankName;
  final String number;
  final int available;

  CardModel({this.id, this.name, this.bankName, this.number, this.available});

  Map toJson() => {
    'id': id,
    'name': name,
    'bankName': bankName,
    'number': number,
    'available': available,
  };

  CardModel.fromJson(Map json) :
      id = json['id'] ,
      name = json['name'] ,
      bankName = json['bankName'] ,
      number = json['number'] ,
      available = json['available'];
}