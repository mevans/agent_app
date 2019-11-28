import 'package:cw2/models/coordinate.dart';
import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final double boxSize;
  final double margin;
  final Coordinate coordinate;
  final double borderRadius;
  final String letter;

  const Block({Key key, this.letter, this.boxSize, this.margin, this.coordinate, this.borderRadius}) : super(key: key);

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Color(0xff29339B),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
      ),
    );
  }
}
