import 'package:flutter/material.dart';

/// A widget that centers its child within a scrollable area. Primarily useful
/// when working with forms where the keyboard may obscure the form fields but
/// may be useful in other scenarios where the child needs to be centered
/// and might become obscured.
class ScrollableCentered extends StatelessWidget {
  /// The child to be centered within the scrollable area.
  final Widget child;

  /// The factor to divide the width of the scrollable area by. Defaults to 2,
  /// meaning the child widget will be half the width of the scrollable area.
  final int widthFactor;

  /// The physics to use for the scrollable area. Defaults to [BouncingScrollPhysics].
  final ScrollPhysics physics;

  const ScrollableCentered(
      {super.key,
      required this.child,
      this.widthFactor = 2,
      this.physics = const BouncingScrollPhysics()});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth / widthFactor,
            height: constraints.maxHeight,
            child: Center(
              child: SingleChildScrollView(
                physics: physics,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
