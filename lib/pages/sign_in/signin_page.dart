import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 登陆与注册的统一入口页
 * @author yinlei.
 */

class SignInPage extends StatelessWidget {
  static String routeName = '/sign_in';

  Widget _buildSignPageHeaderDescription(context) {
    return YlFadeIn(
      child: Column(
        children: [
          Text(
            '躲🐾猫猫',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.ssp,
              fontFamily: 'Yinlei',
            ),
          ),
          SizedBox(
            height: 27.h,
          ),
          Text(
            '一款专为年轻人设计的社交APP，寻找属于年轻人的快乐👦👧',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              letterSpacing: 1.0,
              color: Colors.grey[700],
              height: 1.5,
              fontFamily: 'Yinlei',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignPageContent(context) {
    return YlFadeIn(
      delay: 500,
      child: Container(
        height: 0.4.sh,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? 'assets/icons/cat.png'
                      : 'assets/images/cat.png',
                )
            )
        ),
      ),
    );
  }

  Widget _buildSignChooseBtn(context){
    return YlFadeIn(
      delay: 1000,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.h, left: 3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border(
                bottom: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black),
              ),
            ),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 48.h,
              elevation: 0,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => Navigator.pushNamed(context, LoginPage.routeName),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.ssp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 48.h,
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () => Navigator.pushNamed(context, RegisterPage.routeName),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.ssp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSignPageHeaderDescription(context),
              _buildSignPageContent(context),
              _buildSignChooseBtn(context),
            ],
          ),
        ),
      ),
    );
  }
}
