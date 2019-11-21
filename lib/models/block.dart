import 'coordinate.dart';

// A block is one of the 3 game blocks in the world, either an A, B, or C
class Block {
  final Coordinate goal;
  final String marker;
  Coordinate location;

  // The 3 constructors for the different types of blocks
  Block.a({close = false})
      : location = !close ? Coordinate(1, 4) : Coordinate(4, 2),
        marker = "A",
        goal = Coordinate(2, 2);

  Block.b({close = false})
      : location = !close ? Coordinate(2, 4) : Coordinate(2, 3),
        marker = "B",
        goal = Coordinate(2, 3);

  Block.c({close = false})
      : location = !close ? Coordinate(3, 4) : Coordinate(2, 4),
        marker = "C",
        goal = Coordinate(2, 4);

  Block({this.goal, this.location, this.marker});

  bool inGoalLocation() => location == goal;

  int distanceFromGoal() => location.distance(goal);

  void moveTo(Coordinate coordinate) => this.location.moveTo(coordinate);

  Block clone() => Block(location: location.clone(), goal: goal.clone(), marker: marker);

  String toString() => 'Block{location: $location}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Block &&
              runtimeType == other.runtimeType &&
              goal == other.goal &&
              marker == other.marker &&
              location == other.location;

  @override
  int get hashCode =>
      goal.hashCode ^
      marker.hashCode ^
      location.hashCode;



}
