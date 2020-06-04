import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> _catAnimation,
      _flapAnimation,
      _nameAnimation,
      _boxAnimation;
  AnimationController _catController,
      _flapController,
      _nameController,
      _boxController;

  @override
  void initState() {
    super.initState();

    _catController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _catAnimation = Tween<double>(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: _catController,
        curve: Curves.easeIn,
      ),
    );

    _flapController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );
    _flapAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: _flapController,
        curve: Curves.easeInOut,
      ),
    );
    _flapAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flapController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _flapController.forward();
      }
    });
    _flapController.forward();

    _nameController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _nameAnimation = Tween(begin: 0.0, end: pi * 4.0).animate(
      CurvedAnimation(parent: _nameController, curve: Curves.easeInOut),
    );

    _boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _boxAnimation = Tween(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _boxController, curve: Curves.easeInOut),
    );
    _boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _boxController.forward();
      }
    });
    _boxController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cat'),
        ),
        body: Column(
          children: <Widget>[
            Container(height: 50),
            catName(),
            Container(height: 200),
            GestureDetector(
              child: Center(
                child: AnimatedBuilder(
                  animation: _boxAnimation,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      animatedCat(),
                      box(),
                      leftFlap(),
                      rightFlap(),
                    ],
                  ),
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _boxAnimation.value,
                      child: child,
                    );
                  },
                ),
              ),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget catName() {
    return AnimatedBuilder(
      child: Text(
        'Zoltan',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      animation: _nameAnimation,
      builder: (_, child) {
        return Transform.rotate(
          angle: _nameAnimation.value,
          child: child,
        );
      },
    );
  }

  Widget animatedCat() {
    return AnimatedBuilder(
      child: Cat(),
      animation: _catAnimation,
      builder: (_, child) {
        return Positioned(
          child: child,
          top: _catAnimation.value,
          right: 0,
          left: 0,
        );
      },
    );
  }

  Widget box() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget leftFlap() {
    return AnimatedBuilder(
      animation: _flapAnimation,
      child: Container(
        height: 8,
        width: 110,
        color: Colors.brown,
      ),
      builder: (_, child) {
        return Positioned(
          left: 7,
          top: 4,
          child: Transform.rotate(
            angle: _flapAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          ),
        );
      },
    );
  }

  Widget rightFlap() {
    return AnimatedBuilder(
      animation: _flapAnimation,
      child: Container(
        height: 8,
        width: 110,
        color: Colors.brown,
      ),
      builder: (_, child) {
        return Positioned(
          left: 200,
          top: 0,
          child: Transform.rotate(
            angle: (_flapAnimation.value + pi + 0.1) * -1,
            alignment: Alignment.topLeft,
            child: child,
          ),
        );
      },
    );
  }

  void onTap() {
    if (_catController.status == AnimationStatus.completed ||
        _catController.status == AnimationStatus.forward) {
      _catController.reverse();
      _nameController.reverse();
      _flapController.reset();
      _boxController.reset();
    } else if (_catController.status == AnimationStatus.dismissed ||
        _catController.status == AnimationStatus.reverse) {
      _catController.forward();
      _nameController.forward();
      _flapController.stop();
      _boxController.value = 0;
      _boxController.stop();
    }
  }
}
