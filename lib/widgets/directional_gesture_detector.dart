import 'package:cw2/enums/direction.dart';
import 'package:flutter/material.dart';

class DirectionalGestureDetector extends StatefulWidget {
  final Widget child;
  final ValueChanged<Direction> onSwipe;

  const DirectionalGestureDetector({Key key, this.onSwipe, this.child}) : super(key: key);

  @override
  _DirectionalGestureDetectorState createState() => _DirectionalGestureDetectorState();
}

class _DirectionalGestureDetectorState extends State<DirectionalGestureDetector> {
  Offset startPosition;
  Offset endPosition;

  emitDirection(_) {
    Direction direction;
    Offset delta = startPosition - endPosition;
    if (delta.dy.abs() > delta.dx.abs()) {
      // Vertical
      if (delta.dy > 0) {
        direction = Direction.Up;
      }
      if (delta.dy < 0) {
        direction = Direction.Down;
      }
    } else {
      //Horizontal
      if (delta.dx > 0) {
        direction = Direction.Left;
      }
      if (delta.dx < 0) {
        direction = Direction.Right;
      }
    }
    widget.onSwipe(direction);
  }

  void updateEndPosition(DragUpdateDetails details) {
    setState(() => endPosition += details.delta);
  }

  void setStartAndEndPoints(DragStartDetails details) {
    setState(() {
      startPosition = details.localPosition;
      endPosition = details.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: setStartAndEndPoints,
      onPanUpdate: updateEndPosition,
      onPanEnd: emitDirection,
      child: widget.child,
    );
  }
}
