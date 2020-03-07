import 'dart:math';

import 'package:flutter/material.dart';

import '../widget/animated_background.dart';
import '../widget/animated_wave.dart';
import '../widget/particles.dart';
import './home_page_content.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: AnimatedBackground()),
          Positioned.fill(child: Particles(10)),
          onBottom(
            AnimatedWave(
              height: 180,
              speed: 1.0,
            ),
          ),
          onBottom(
            AnimatedWave(
              height: 120,
              speed: 0.9,
              offset: pi,
            ),
          ),
          onBottom(AnimatedWave(
            height: 220,
            speed: 1.2,
            offset: pi / 2,
          )),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: <Widget>[]))),
          Positioned.fill(child: HomePageContent()),
        ],
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
