import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
/**
 * 登陆页
 * @author yinlei.
 */
class LoginPage extends StatefulWidget {
  static String routeName = '/sign_in_login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var isReaded = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  bool showPwd = false;

  TapGestureRecognizer _tapGestureRecognizer;

  /// rive.
  final riveFileName = 'assets/rives/neon_car.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handlePress;
  }

  /// load rive file.
  void _loadRiveFile() async {
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load(riveFileName).then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_riveController = SimpleAnimation('drive'));
        setState(() => _artboard = artboard);
      },
    ).catchError((e) => print(e));
  }

  void _handlePress() {
    Navigator.of(context).pushNamed(RegisterPage.routeName);
  }

  Widget _buildLoginHeader() {
    return YlFadeIn(
      child: Column(
        children: [
          _artboard != null ? Container(
            width: 1.sw,
            height: 0.3.sh,
            child: Rive(
              artboard: _artboard,
              fit: BoxFit.cover,
            ),
          ) : Text('Loading...'),
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
            child: Column(
              children: [
                Text(
                  '躲🐱猫猫',
                  style: TextStyle(
                    fontSize: 30.ssp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    '登录您的账号，就可以进入APP和陌生人参与聊天、分享视频等活动🎈',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, fontSize: 14.ssp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginInputField() {
    return YlFadeIn(
      delay: 500,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 36.h),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormWidget(
                controller: _userNameController,
                labelText: '用户名',
                hintText: 'Account',
                marginTop: 0,
              ),
              TextFormWidget(
                controller: _userPasswordController,
                labelText: '密码',
                hintText: 'Password',
                isPassword: true,
                obscureText: !showPwd,
                suffixIcon: IconButton(
                  icon: Icon(
                    !showPwd ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      showPwd = !showPwd;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  text: TextSpan(
                      text: '还没有账号?',
                      style: Theme.of(context).textTheme.bodyText1,
                      children: <TextSpan>[
                        TextSpan(
                          text: '注册',
                          recognizer: _tapGestureRecognizer,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppColors.ylPrimaryColor,
                            fontSize: 18.ssp,
                          ),
                        ),
                        TextSpan(
                          text: '加入大家庭',
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(){
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return YlFadeIn(
          delay: 800,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w,),
            child:  Container(
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
                onPressed: isReaded ? () async {
                  /// 登录
                  if((_formKey.currentState as FormState).validate()) {
                    User params = User(
                      name: _userNameController.value.text.trim(),
                      password: _userPasswordController.value.text.trim(),
                    );
                    Login res = await UserApi.login(context: context, params: params);
                    if(res != null){
                      AppGlobal.profile.token = res.token;
                      params.uid = res.uid;
                      userModel.user = params;
                      await appShowToast(msg: '登录成功@: ${res.token}');
                      Navigator.of(context).pushNamed(ApplicationPage.routeName);
                    }
                  }
                } : null,
                color: AppColors.ylPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '登    陆',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.ssp,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginFooter() {
    return YlFadeIn(
      delay: 1000,
      child: Container(
        height: 0.4.sh,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/landscape.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isReaded,
                      onChanged: (value) {
                        setState(() {
                          isReaded = value;
                        });
                      },
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: '阅读并同意',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              text: '《躲猫猫用户协议》',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.ylPrimaryColor,
                                fontSize: 16.ssp,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 30.h,
              child: Image.asset(MediaQuery.of(context).platformBrightness == Brightness.light ? 'assets/images/sun.png' : 'assets/images/moon.png'),
            ),
            Positioned(
              left: 25.w,
              top: 45.h,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 100.w,
                ),
                child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image.asset('assets/images/cloud.png',)),
              ),
            ),
            Positioned(
              bottom: 20.h,
              right: 22.h,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 90.w,
                ),
                child: Image.asset('assets/images/tree.png', fit: BoxFit.cover,),
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 50.h,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 100.w,
                ),
                child: Image.asset('assets/images/tree.png', fit: BoxFit.cover,),
              ),
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLoginHeader(),
            _buildLoginInputField(),
            _buildLoginButton(),
            SizedBox(
              height: 30.h,
            ),
            _buildLoginFooter(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userPasswordController.dispose();
    _tapGestureRecognizer.dispose();
    _riveController.dispose();
    super.dispose();
  }

}

