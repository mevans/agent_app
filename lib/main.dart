import 'package:cw2/enums/direction.dart';
import 'package:cw2/models/blockworld.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/complete_dialog.dart';
import 'widgets/directional_gesture_detector.dart';
import 'widgets/world_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AgentApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AgentApp extends StatefulWidget {
  @override
  _AgentAppState createState() => _AgentAppState();
}

class _AgentAppState extends State<AgentApp> {
  Blockworld world = Blockworld.start();
  int moves = 0;

  void makeMove(Direction direction, BuildContext context) {
    if (!world.canMove(direction)) return;
    setState(() {
      world.move(direction);
      moves++;
    });
    if (world.isFinishState()) {
      showDialog(
        context: context,
        builder: (ctx) => CompleteDialog(
          moves: moves,
          restartGame: restartGame,
        ),
      );
    }
  }

  void restartGame() {
    setState(() {
      world = Blockworld.start();
      moves = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return DirectionalGestureDetector(
      onSwipe: (d) => makeMove(d, context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Moves",
              style: TextStyle(fontSize: 24, color: Color(0xffFF3A20), fontWeight: FontWeight.w600),
            ),
            Text(
              "$moves",
              style: TextStyle(fontSize: 56, color: Color(0xffFF3A20), fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: WorldGrid(
                world: world,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 38,
                  color: Color(0xff29339B),
                ),
                onPressed: restartGame,
              )
            ])
          ],
        ),
      ),
    );
  }
}
