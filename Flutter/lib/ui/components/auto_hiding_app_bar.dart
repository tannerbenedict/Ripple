import 'dart:async';

import 'package:flutter/material.dart';

const _shownHeight = 50.0;
const _hiddenHeight = 30.0;

class AutoHidingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Duration visibleFor;
  final bool alwaysVisible;

  AutoHidingAppBar(
      {required this.title,
      this.actions = const <Widget>[],
      this.visibleFor = const Duration(seconds: 2),
      this.alwaysVisible = false});

  @override
  Size get preferredSize => Size.fromHeight(_shownHeight);

  @override
  State<StatefulWidget> createState() => _AutoHidingAppBarState();
}

class _AutoHidingAppBarState extends State<AutoHidingAppBar> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _curve = Curves.easeIn;
  late Timer? _timer;
  var _visible = true;

  @override
  void initState() {
    super.initState();
    if (!widget.alwaysVisible) {
      _timer = Timer(widget.visibleFor, _hideAppBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: widget.alwaysVisible
          ? null
          : (details) {
              if (details.delta.dy < 0) {
                _showAppBar();
              } else {
                _immediatelyHideAppBar();
              }
            },
      onLongPressDown: widget.alwaysVisible
          ? null
          : (_) {
              _showAppBar();
              _hideAppBar();
            },
      onTapDown: widget.alwaysVisible
          ? null
          : (_) {
              _showAppBar();
              _hideAppBar();
            },
      child: MouseRegion(
          onEnter: widget.alwaysVisible ? null : (event) => _showAppBar(),
          onExit: widget.alwaysVisible ? null : (event) => _hideAppBar(),
          child: AnimatedContainer(
              duration: _animationDuration,
              curve: _curve,
              height: _visible ? _shownHeight : _hiddenHeight,
              child: AnimatedSwitcher(
                  duration: _animationDuration,
                  reverseDuration: _animationDuration,
                  switchInCurve: _curve,
                  switchOutCurve: _curve,
                  transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: _visible
                      ? AppBar(
                          leading: BackButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Are you sure you want\nto leave the game?",
                                    textAlign: TextAlign.center,
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    ElevatedButton(
                                      style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style
                                              ?.copyWith(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .error),
                                              ) ??
                                          ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .errorContainer,
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .error),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).maybePop();
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          centerTitle: true,
                          title: widget.title,
                          actions: widget.actions,
                        )
                      : SizedBox.expand()))),
    );
  }

  void _showAppBar() {
    _timer!.cancel();
    setState(() {
      _visible = true;
    });
  }

  void _immediatelyHideAppBar() {
    if (!widget.alwaysVisible) {
      _timer!.cancel();
      setState(() {
        _visible = false;
      });
    }
  }

  void _hideAppBar() {
    if (!mounted) {
      return;
    }

    _timer = Timer(widget.visibleFor, () {
      if (mounted) {
        setState(() {
          _visible = false;
        });
      }
    });
  }
}
