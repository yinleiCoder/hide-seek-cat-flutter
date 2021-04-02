import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/card_model.dart';
import 'package:flutter_hide_seek_cat/common/providers/cardcost.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:provider/provider.dart';
/**
 * 添加银行卡和交易信息
 * @author yinlei
*/
class AddCardPage extends StatefulWidget {
  static String routeName = '/add_card_page';

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _availableController = TextEditingController();

  void _handleAddCard() {
    CardModel card = CardModel(
      name: _nameController.text,
      number: _numberController.text,
      bankName: _bankNameController.text,
      available: num.tryParse(_availableController.text),
    );
    Provider.of<CardProvider>(context, listen: false).addCard(card);
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _bankNameController.dispose();
    _availableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.h,
            floating: false,
            snap: false,
            pinned: false,
            centerTitle: true,
            stretch: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            onStretchTrigger: () {
              /// 刷新内容
            },
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Hero(
                tag: 'card_view',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://img.zcool.cn/community/01506f606431ab11013fb11722cf96.jpg@1280w_1l_2o_100sh.jpg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(15.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.r),
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.title, color: Colors.black45,),
                          hintText: '银行卡',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.r),
                      child: TextField(
                        controller: _numberController,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.title, color: Colors.black45,),
                          hintText: '银行卡号',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.r),
                      child: TextField(
                        controller: _bankNameController,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.title, color: Colors.black45,),
                          hintText: '银行',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.r),
                      child: TextField(
                        controller: _availableController,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.title, color: Colors.black45,),
                          hintText: '可用余额',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    padding: EdgeInsets.all(15.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    onPressed: _handleAddCard,
                    color: AppColors.ylPrimaryColor,
                    child: Text('添加', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5,),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
