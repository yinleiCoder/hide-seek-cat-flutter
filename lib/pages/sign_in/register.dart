import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:rive/rive.dart';
/**
 * 注册页
 * @author yinlei.
 */
class RegisterPage extends StatefulWidget {
  static String routeName = '/sign_in_register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;
  GlobalKey _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController = TextEditingController();

  /// rive.
  final riveFileName = 'assets/rives/marine_corps_running.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(_scaleController)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          _widthController.forward();
        }
      });
    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(_widthController)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _positionAnimation = Tween(
      begin: 0.0,
      end: 210.0,
    ).animate(_positionController)
      ..addStatusListener((status) async {
        if(status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          /// 验证表单
          if((_registerFormKey.currentState as FormState).validate()) {
            if(_userPasswordController.value.text.trim() != _userConfirmPasswordController.value.text.trim()) {
              await appShowToast(msg: "密码和确认密码不一致");
              setState(() {
                hideIcon = false;
              });
              _scaleController.reverse();
              _widthController.reverse();
              _positionController.reverse();
            }else {
              User params = User(
                name: _userNameController.value.text.trim(),
                password: _userPasswordController.value.text.trim(),
              );
              User res = await UserApi.register(context: context, params: params);
              if(res != null){
                /// 后台确认注册成功再启动动画并跳转
                _scale2Controller.forward();
              }
            }
          } else { /// 表单验证失败动画重置
            setState(() {
              hideIcon = false;
            });
            _scaleController.reverse();
            _widthController.reverse();
            _positionController.reverse();
          }
        }
      });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _scale2Animation = Tween(
      begin: 1.0,
      end: 32.0,
    ).animate(_scale2Controller)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          Navigator.pushNamed(context, LoginPage.routeName);
        }
      });
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
        artboard.addController(_riveController = SimpleAnimation('Run'));
        setState(() => _artboard = artboard);
      },
    ).catchError((e) => print(e));
  }

  Widget _buildRegisterHeader() {
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
            padding: EdgeInsets.only(top: 40.h, left: 30.w, right: 30.w),
            child: Opacity(
              opacity: 0.6,
              child: Text(
                '还在等什么？长得好看的人已经在注册账号了！加入躲猫猫社区🎃，和其他小哥哥、小姐姐们一起嗨翻天吧！🤭',
                style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, fontSize: 14.ssp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return YlFadeIn(
      delay: 500,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,),
        child: Form(
          key: _registerFormKey,
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
                  obscureText: true,
                  suffixIcon: Icon(Icons.lock_rounded)
              ),
              TextFormWidget(
                  controller: _userConfirmPasswordController,
                  labelText: '确认密码',
                  hintText: 'Confirm password',
                  isPassword: true,
                  obscureText: true,
                  suffixIcon: Icon(Icons.lock_rounded)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterFooter() {
    return YlFadeIn(
      delay: 800,
      child: AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedBuilder(
            animation: _widthController,
            builder: (context, child) {
              return Container(
                width: _widthAnimation.value.r,
                height: 80.r,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.ylPrimaryColor.withOpacity(.4),
                ),
                child: InkWell(
                  onTap: () {
                    _scaleController.forward();
                  },
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                          animation: _positionController,
                          builder: (context, child) {
                            return Positioned(
                              left: _positionAnimation.value,
                              child: AnimatedBuilder(
                                animation: _scale2Controller,
                                builder: (context, child) => Transform.scale(
                                  scale: _scale2Animation.value,
                                  child: Container(
                                    width: 60.r,
                                    height: 60.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.ylPrimaryColor,
                                    ),
                                    child: hideIcon == false ? Icon(Icons.arrow_forward, color: Colors.white,) : Container(),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
            _buildRegisterHeader(),
            SizedBox(
              height: 40.h,
            ),
            _buildRegisterForm(),
            SizedBox(
              height: 40.h,
            ),
            _buildRegisterFooter(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _scale2Controller.dispose();
    _positionController.dispose();
    _widthController.dispose();

    _userNameController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();

    _riveController.dispose();
    super.dispose();
  }

}

