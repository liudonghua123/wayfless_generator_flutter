import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

/// see more on https://juejin.im/post/5e1d5b9b6fb9a03013306588
class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Colors.white, end: Colors.blueAccent)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Colors.purple, end: Colors.white))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}
