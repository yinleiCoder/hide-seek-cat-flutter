import 'package:flutter/material.dart';
import 'dart:async';
/**
 * 动画floatactionbutton
 * @author yinlei
*/
class AnimatedFloatingActionButton extends StatefulWidget {
  final List<Widget> fabButtons;
  final Color colorStartAnimation;
  final Color colorEndAnimation;
  final AnimatedIconData animatedIconData;

  AnimatedFloatingActionButton(
      {Key key,
        this.fabButtons,
        this.colorStartAnimation,
        this.colorEndAnimation,
        this.animatedIconData})
      : super(key: key);

  @override
  AnimatedFloatingActionButtonState createState() =>
      AnimatedFloatingActionButtonState();
}

class AnimatedFloatingActionButtonState
    extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  bool isOpenedVisible = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: widget.colorStartAnimation,
      end: widget.colorEndAnimation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  delayOpen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      isOpenedVisible = !isOpenedVisible;
    });
  }

  animate() {
    if (!isOpened) {
      isOpenedVisible = !isOpenedVisible;
      _animationController.forward();
    } else {
      _animationController.reverse();
      delayOpen();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          color: Colors.white,
          icon: widget.animatedIconData,
          progress: _animateIcon,
        ),
      ),
    );
  }

  List<Widget> _setFabButtons() {
    List<Widget> processButtons = List<Widget>();
    for (int i = 0; i < widget.fabButtons.length; i++) {
      processButtons.add(TransformFloatButton(
        floatButton: Visibility(
          child: widget.fabButtons[i],
          visible: isOpenedVisible,
        ),
        translateValue: _translateButton.value * (widget.fabButtons.length - i),
      ));
    }
    processButtons.add(toggle());
    return processButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _setFabButtons(),
    );
  }
}

class BounceInLeftContainer extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInLeftContainer(
      {this.key,
        this.child,
        this.duration = const Duration(milliseconds: 1000),
        this.delay = const Duration(milliseconds: 0),
        this.controller,
        this.manualTrigger = false,
        this.animate = true,
        this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceInLeftContainerState createState() => _BounceInLeftContainerState();
}

class _BounceInLeftContainerState extends State<BounceInLeftContainer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

class FloatActionButtonText extends StatelessWidget {
  final String text;
  final IconData icon;
  final double textTop;
  final double textLeft;
  final Color childBgColor;
  final VoidCallback onPressed;
  const FloatActionButtonText({
    Key key,
    this.icon,
    this.text,
    this.textLeft = -110,
    this.textTop = -10,
    this.onPressed, this.childBgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: icon==null? Colors.white: null,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            icon!=null ? Icon(icon, color: Colors.white,) : CircleAvatar(backgroundColor: childBgColor,),
            Positioned(
              top: textTop,
              right: 50,
              child: BounceInLeftContainer(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransformFloatButton extends StatelessWidget {
  final Widget floatButton;
  final double translateValue;

  TransformFloatButton({this.floatButton, this.translateValue})
      : super(key: ObjectKey(floatButton));

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        translateValue,
        0.0,
      ),
      child: floatButton,
    );
  }
}