import 'package:cw2/models/coordinate.dart';
import 'package:flutter/material.dart';

class Agent extends StatelessWidget {
  final Coordinate coordinate;
  final double boxSize;
  final double margin;
  final double borderRadius;

  const Agent({Key key, this.coordinate, this.boxSize, this.margin, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      top: (coordinate.y - 1) * boxSize + (margin * coordinate.y),
      left: (coordinate.x - 1) * boxSize + (margin * coordinate.x),
      duration: Duration(milliseconds: 150),
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: Color(0xffFF3A20), boxShadow: [
          BoxShadow(color: Color(0xffFF3A20).withOpacity(0.5), spreadRadius: 1, blurRadius: 5),
        ]),
      ),
    );
  }
}
