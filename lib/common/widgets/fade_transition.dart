import 'package:flutter/material.dart';

/**
 * 封装官方的FadeTransition组件
 * @author yinlei
*/
class YlFadeIn extends StatefulWidget {
  final Widget child;
  final int delay; /// 动画延迟时间
  final int duration; /// 动画持续时间

  const YlFadeIn({Key key, this.child, this.delay = 0, this.duration = 2}) : super(key: key);
  @override
  _YlFadeInState createState() => _YlFadeInState();
}

class _YlFadeInState extends State<YlFadeIn> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(
      milliseconds: widget.delay
    ), () {
      _controller.forward();
    });
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

