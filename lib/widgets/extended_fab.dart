import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:vocab_king/modify_word_page/modify_word_page.dart';
import 'package:flutter/rendering.dart';

class ExtendedFab extends StatefulWidget {
  @override
  _ExtendedFabState createState() => _ExtendedFabState();
}

class _ExtendedFabState extends State<ExtendedFab> with
  SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _labelOpacityTransformation;
  Animation<double> _animation;
  Animation<double> _buttonTransformation;

  Curve _curve = Curves.easeOut;
  double _fabHeight = 48.0;

  @override
  initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonTransformation = Tween<double>(
      begin: _fabHeight,
      end: -8.0,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.75,
          curve: _curve,
        ),
    ));

    _labelOpacityTransformation = Tween<double>(
      begin: 0,
      end: 255,
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {

      });
    });

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  void reveal() {
    _animationController.forward();
    isOpened = true;
  }

  void hide() {
    _animationController.reverse();
    isOpened = false;
  }

  Widget toggleButton() {
    return FloatingActionButton(
      onPressed: isOpened ? hide : reveal,
      tooltip: 'Add',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animation,
      ),
    );
  }

  Widget _actionButton({String label, String tooltip, Icon icon, void Function() callback}) {
    List<Widget> children = <Widget>[];
    if(!_animation.isDismissed) {
      children.addAll([
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: Color.fromARGB(_labelOpacityTransformation.value.round(), 200, 200, 200),
          ),
          padding: EdgeInsets.all(5.0),
          child: Text(label,
              style: TextStyle(
                color: Color.fromARGB(_labelOpacityTransformation.value.round(), 0, 0, 0),
              )
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0,0,10,0)),
      ]);
    }

    children.addAll([
      FloatingActionButton(
        heroTag: label ?? tooltip,
        onPressed: callback,
        tooltip: tooltip ?? label,
        mini: true,
        child: icon,
      ),
      Padding(padding: EdgeInsets.fromLTRB(0,0,4,0)),
    ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO: consider implementing this as a ModalRoute or ModalBarrier
        GestureDetector(
          onTapDown: isOpened ? (tdd) => hide() : null,
          onVerticalDragStart: isOpened ? (x) => hide() : null,
          onHorizontalDragStart: isOpened ? (x) => hide() : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform(
                  transform: Matrix4.translationValues(0.0, _buttonTransformation.value * 3, 0.0),
                  child: _actionButton(label: "Add phrase", icon: Icon(Icons.chat_bubble), callback: () => hide())//addPhraseButton(),
              ),
              Transform(
                transform: Matrix4.translationValues(0.0, _buttonTransformation.value * 2, 0.0),
                child: _actionButton(label: "Add picture", icon: Icon(Icons.photo_camera), callback: () => hide()),//addPictureButton(),
              ),
              Transform(
                transform: Matrix4.translationValues(0.0, _buttonTransformation.value, 0.0),
                child: _actionButton(
                  label: "Add word",
                  icon: Icon(Icons.font_download),
                  callback: () {
                    hide();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyWordPage()));
                  },
                ),
              ),
              toggleButton(),
            ],
          ),
        ),
      ],
    );
  }
}