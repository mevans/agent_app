import 'package:flutter/material.dart';

class CompleteDialog extends StatelessWidget {
  final int moves;
  final VoidCallback restartGame;

  const CompleteDialog({Key key, this.moves, this.restartGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "Level Complete!",
            style: TextStyle(color: Color(0xff29339B), fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "$moves",
                style: TextStyle(fontSize: 72, color: Color(0xffFF3A20), fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 10),
              Text(
                "moves",
                style: TextStyle(fontSize: 28, color: Color(0xffFF3A20), fontWeight: FontWeight.w600),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.refresh,
                size: 38,
                color: Color(0xff29339B),
              ),
              onPressed: () {
                restartGame();
                Navigator.pop(context);
              }
          )
        ]),
      ),
    );
  }
}
