import 'package:collection/collection.dart';

import '../models/blockworld.dart';
import '../models/search_result.dart';

// This search method uses a list to store which states have been seen
SearchResult aStarSearch(Blockworld startState) {
  List<String> seen = [];
  SearchResult result = SearchResult(searchMethod: "A* Search");
  // Create a priority queue, which automatically sorts the states when they are added (by their distance from the goal)
  PriorityQueue<Blockworld> priorityQueue = PriorityQueue((s1, s2) => s1.distanceFromGoal() - s2.distanceFromGoal());
  priorityQueue.add(startState);
  int nodesExpanded = 0;

  while (priorityQueue.isNotEmpty) {
    Blockworld state = priorityQueue.removeFirst();
    // Only do something if the state hasn't been seen
    if (!seen.contains(state.toString())) {
      if (state.isFinishState()) {
        result.finalState = state;
        result.nodesExpanded = nodesExpanded;
        return result;
      }
      // Increment the nodes expanded and add the valid children to the queue
      nodesExpanded++;
      priorityQueue.addAll(state.generateChildren(mustBeValidMove: true));
      seen.add(state.toString());
    }
  }
  return result;
}
