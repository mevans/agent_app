import 'package:agent_app/models/blockworld.dart';
import 'package:agent_app/models/coordinate.dart';
import 'package:flutter/material.dart';

import 'agent.dart';
import 'block.dart';

class WorldGrid extends StatefulWidget {
  final Blockworld world;

  const WorldGrid({Key key, this.world}) : super(key: key);

  @override
  _WorldGridState createState() => _WorldGridState();
}

class _WorldGridState extends State<WorldGrid> {
  final List<UniqueKey> keys = List.generate(16, (_) => UniqueKey());
  final double margin = 8;
  final borderRadius = 6.0;

  List<Widget> buildBackGrid(boxSize) {
    return List.generate(
      16,
      (i) {
        final row = (i / 4).floor();
        final column = (i % 4);
        return Positioned(
          top: row * boxSize + (margin * (row + 1)),
          left: column * boxSize + (margin * (column + 1)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Color(0xffB6D6CC),
            ),
            width: boxSize,
            height: boxSize,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, size) {
        final boxSize = (size.biggest.width - (5 * margin)) / 4;
        final agent = widget.world.agent;
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.biggest.width, maxHeight: size.biggest.width),
          child: Stack(
            children: [
              ...buildBackGrid(boxSize),
              ...[widget.world.a, widget.world.b, widget.world.c].map((block) => Block(
                    letter: block.marker,
                    coordinate: block.location,
                    borderRadius: borderRadius,
                    margin: margin,
                    boxSize: boxSize,
                  )),
              Agent(
                coordinate: agent,
                boxSize: boxSize,
                margin: margin,
                borderRadius: borderRadius,
              )
            ],
          ),
        );
      },
    );
  }
}
