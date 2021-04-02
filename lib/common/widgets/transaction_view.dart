import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 开支助手
 * 交易信息小卡片
 * @author yinlei
*/
class TransactionView extends StatefulWidget {
  final TransactionModel transactionModel;

  const TransactionView({Key key, this.transactionModel}) : super(key: key);
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.transactionModel.type == '-' ? Icon(Icons.arrow_downward, color: Colors.redAccent,) : Icon(Icons.arrow_upward, color: Colors.greenAccent,),
                SizedBox(width: 10.w,),
                Text(widget.transactionModel.name, style: TextStyle(fontSize: 16.ssp, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey,),)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.transactionModel.type+widget.transactionModel.price.toString(), style: TextStyle(color: widget.transactionModel.type == '-' ? Colors.redAccent : Colors.greenAccent, letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 18.ssp,),),
                Text('￥', style: TextStyle(color: Colors.grey, letterSpacing: 1.5,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

