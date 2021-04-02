import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hide_seek_cat/common/entitys/card_model.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/widgets/card_view.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
import 'package:flutter_hide_seek_cat/common/widgets/transaction_view.dart';
import 'package:flutter_hide_seek_cat/pages/square/add_card_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:provider/provider.dart';
/**
 * 开支记账助手
 * @author yinlei
*/
class CostRecordPage extends StatefulWidget {
  static String routeName = '/cost_record_page';

  @override
  _CostRecordPageState createState() => _CostRecordPageState();
}

class _CostRecordPageState extends State<CostRecordPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<CardProvider>(context).initalState();
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 150.h,
            floating: false,
            snap: false,
            pinned: false,
            centerTitle: true,
            stretch: true,
            actions: [
              IconButton(
                icon: CircleAvatar(
                  backgroundColor: AppColors.ylPrimaryColor,
                  child: Icon(Icons.add, color: Colors.white,),
                ),
                onPressed: () {
                  if(Provider.of<CardProvider>(context, listen: false).getCardLength() < 1) {
                    Navigator.of(context).pushNamed(AddCardPage.routeName,);
                  }else {
                    appShowToast(msg: '暂时只支持一张银行卡哦！');
                  }
                },
              ),
            ],
            onStretchTrigger: () {
              /// 刷新内容
            },
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/dog.jpg'),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (
                    Provider.of<CardProvider>(context).getCardLength() == 1 ?
                    Hero(
                      tag: 'card_view',
                      child: Container(
                        height: 210.h,
                        child: Consumer<CardProvider>(
                          builder: (context, cards, child) => CardView(
                            card: CardModel(
                              available: cards.cards[0].available,
                              name: cards.cards[0].name,
                              number: cards.cards[0].number,
                            ),
                          ),
                        ),
                      ),
                    ) :
                    Hero(
                      tag: 'card_view',
                      child: Container(
                        height: 210.h,
                        child: CardView(
                          card: CardModel(
                            available: 0,
                            name: '未添加',
                            number: '**** **** **** **** ***',
                          ),
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 30.h,),
                  Text('最近账单(添加开支记录还没做)', style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: AppColors.ylPrimaryColor,),),
                  SizedBox(height: 10.h,),
                  TransactionView(
                    transactionModel: TransactionModel(
                      name: '成都租房',
                      type: '-',
                      price: 600,
                    ),
                  ),
                  TransactionView(
                    transactionModel: TransactionModel(
                      name: '奖学金',
                      type: '+',
                      price: 5000,
                    ),
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
