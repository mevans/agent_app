import '../enums/direction.dart';
import 'block.dart';
import 'coordinate.dart';

class Blockworld {
  Block a;
  Block b;
  Block c;
  Coordinate agent;
  Blockworld parent;
  Direction directionMoved;

  Blockworld({this.a, this.b, this.c, this.agent, this.parent});

  Blockworld.start()
      : a = Block.a(),
        b = Block.b(),
        c = Block.c(),
        agent = Coordinate(4, 4);

  // Create a world which is close to the final state, to make it easier for search methods
  Blockworld.close()
      : a = Block.a(close: true),
        b = Block.b(close: true),
        c = Block.c(close: true),
        agent = Coordinate(2, 2);

  // Clone the object to remove the references
  Blockworld clone() => Blockworld(
      a: this.a.clone(), b: this.b.clone(), c: this.c.clone(), agent: this.agent.clone(), parent: this.parent);

  // The world is in the finish state if the 3 blocks are
  bool isFinishState() => a.inGoalLocation() && b.inGoalLocation() && c.inGoalLocation();

  // Check if the agent can move in a given direction without 'going off' the grid
  bool canMove(Direction direction) {
    return (direction == Direction.Up && agent.y > 1 ||
        direction == Direction.Down && agent.y < 4 ||
        direction == Direction.Left && agent.x > 1 ||
        direction == Direction.Right && agent.x < 4);
  }

  void move(Direction direction) {
    if (!canMove(direction)) return;
    // Create a movement vector based on the direction
    Coordinate movementVector;
    switch (direction) {
      case Direction.Up:
        movementVector = Coordinate(0, -1);
        break;
      case Direction.Down:
        movementVector = Coordinate(0, 1);
        break;
      case Direction.Left:
        movementVector = Coordinate(-1, 0);
        break;
      case Direction.Right:
        movementVector = Coordinate(1, 0);
        break;
    }
    Coordinate movingInto = this.agent + movementVector;
    // Switch block and agent positions if the agent is moving into a block
    if (blockAt(movingInto) != null) {
      blockAt(movingInto).moveTo(this.agent);
    }

    this.agent.moveTo(movingInto);
  }

  // Generate the children for this state ie. a list of this state moved in the 4 directions
  List<Blockworld> generateChildren({bool randomise = false, bool mustBeValidMove = true}) {
    List<Blockworld> children = [];
    Direction.values.forEach((direction) {
      if (this.canMove(direction) || !mustBeValidMove) {
        Blockworld clone = this.clone()
          ..parent = this
          ..directionMoved = direction
          ..move(direction);
        children.add(clone);
      }
    });
    if (randomise) {
      children.shuffle();
    }
    return children;
  }

  // Return the block at the coordinate
  Block blockAt(Coordinate coordinate) {
    if (a.location == coordinate) return a;
    if (b.location == coordinate) return b;
    if (c.location == coordinate) return c;
    return null;
  }

  // The heuristic which is used in the A* search - all of the blocks distances from the goal
  int distanceFromGoal() => this.a.distanceFromGoal() + this.b.distanceFromGoal() + this.c.distanceFromGoal();

  // Find the depth of the current state by navigation to the parent of the parent of the parent... and incrementing
  int findDepth() {
    int depth = 0;
    Blockworld lookingAt = this;
    while (lookingAt.parent != null) {
      depth++;
      lookingAt = lookingAt.parent;
    }
    return depth;
  }

  // Generates the sequence from the start state to the current state
  List<Blockworld> generateSequence() {
    List<Blockworld> allLevels = [this];
    Blockworld lookingAt = this;
    while (lookingAt.parent != null) {
      lookingAt = lookingAt.parent;
      allLevels.add(lookingAt);
    }
    return allLevels.reversed.toList();
  }

  // Display the directions moved from the start state to the current state
  void displayCondensed() {
    for (Blockworld state in generateSequence()) {
      if (state.directionMoved == null) {
        print("Start State");
      } else {
        print(state.directionMoved.toString().split(".")[1]);
      }
    }
  }

  // Display directions moved as well as the world
  void displayMoves() {
    for (Blockworld state in generateSequence()) {
      if (state.directionMoved == null) {
        print("Start State");
      } else {
        print(state.directionMoved);
      }
      print(state);
    }
  }

  // Create visual representation of the board
  @override
  String toString() {
    String string = "";
    for (int y = 1; y < 5; y++) {
      for (int x = 1; x < 5; x++) {
        Coordinate coordinate = Coordinate(x, y);
        Block block = blockAt(coordinate);
        if (agent == coordinate) {
          string += "⧆";
        } else if (block != null) {
          string += block.marker;
        } else {
          string += "□";
        }
      }
      string += "\n";
    }
    return string;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Blockworld &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          agent == other.agent &&
          parent == other.parent &&
          directionMoved == other.directionMoved;

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ c.hashCode ^ agent.hashCode ^ parent.hashCode ^ directionMoved.hashCode;
}
