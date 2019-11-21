import 'dart:collection';

import '../models/blockworld.dart';
import '../models/search_result.dart';

SearchResult breadthFirstSearch(Blockworld startState) {
  SearchResult result = SearchResult(searchMethod: "Breadth First Search");
  Queue<Blockworld> queue = Queue.from([startState]);
  int nodesExpanded = 0;

  while (queue.isNotEmpty) {
    Blockworld state = queue.removeFirst();
    if (state.isFinishState()) {
      // If the final state is found, add the data to the result object and return it
      result.finalState = state;
      result.nodesExpanded = nodesExpanded;
      return result;
    }
    // A node has been expanded, and add its children to the queue
    nodesExpanded++;
    queue.addAll(state.generateChildren());
  }
  return result;
}
