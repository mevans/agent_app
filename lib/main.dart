import 'dart:async';

import 'package:agent_app/models/blockworld.dart';
import 'package:agent_app/search_methods/iterative_deepening_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

import 'enums/direction.dart';
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
  List<Blockworld> currentMovement = [];
  ScreenshotController screenshotController = ScreenshotController();
  Timer timer;

  void startMoving() {
    takeScreenshot();
    timer = Timer.periodic(Duration(milliseconds: 200), (d) {
      if (currentMovement.length == 1) timer.cancel();
      Blockworld last = currentMovement.removeLast();
      makeMove(last.directionMoved, context);
      takeScreenshot();
    });
  }

  void takeScreenshot() {
    screenshotController.capture(delay: Duration(milliseconds: 1)).then((file) {
      print(file);
    });
  }

  void makeMove(Direction direction, BuildContext context) {
    if (!world.canMove(direction)) return;
    setState(() {
      world.move(direction);
      moves++;
    });
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
    this.currentMovement = iterativeDeepeningSearch(world).finalState.generateSequence().reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return DirectionalGestureDetector(
      onSwipe: (d) => makeMove(d, context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(actions: [
          FlatButton(
            child: Text("IDS"),
            onPressed: () {
              startMoving();
            },
          ),
        ]),
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
            Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WorldGrid(
                  world: world,
                ),
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
