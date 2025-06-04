import 'package:flutter/material.dart';
import 'dart:math';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  double _buttonRadius = 100.0;

  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _startIconAnimationController;

  @override
  void initState() {
    super.initState();
    _startIconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _startIconAnimationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButton(),
                _starIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale, 
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(seconds: 1), 
      builder: (_context, double _scale, _child) {
         return Transform.scale(
            scale: _scale,
            child: _child,
          );
      },
      child: Container(
        color: Colors.blue,
      ),
      );
  }

  Widget _circularAnimationButton() {
    return Center (
      child: GestureDetector(
      onTap: () {
        setState(() {
          _buttonRadius += _buttonRadius == 200.0 ? -100.0 : 100.0;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.bounceInOut,
        height: _buttonRadius,
        width: _buttonRadius,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100)
        ),
        child: const Center(
          child: Text(
            "Basic!",
            style: TextStyle(
              color: Colors.red
            ),
          ),
        ),
      )
    ,)
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _startIconAnimationController!.view, 
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _startIconAnimationController!.value * 2 * pi,
          child: _child,
          );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.yellow,
      )
    );
  }
}