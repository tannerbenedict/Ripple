import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  final Widget child;
  final bool makeFullScreen;

  const GameBackground(
      {super.key, required this.child, this.makeFullScreen = true});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).padding.right +
            MediaQuery.of(context).padding.left);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? "./images/oak_background.jpg"
                      : "./images/dark_background.jpg")
              .image,
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: makeFullScreen
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(height: height, width: width, child: child),
              )
            : child,
      ),
    );
  }
}
