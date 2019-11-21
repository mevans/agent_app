import 'dart:collection';

import '../models/blockworld.dart';
import '../models/search_result.dart';

SearchResult depthFirstSearch(Blockworld startState) {
  SearchResult result = SearchResult(searchMethod: "Depth First Search");
  ListQueue<Blockworld> stack = ListQueue.from([Blockworld.close()]);
  int nodesExpanded = 0;

  while (stack.isNotEmpty) {
    Blockworld state = stack.removeFirst();
    if (state.isFinishState()) {
      result.nodesExpanded = nodesExpanded;
      result.finalState = state;
      return result;
    }
    nodesExpanded++;
    // Add the children to the top of the stack
    state.generateChildren().forEach((child) {
      stack.addFirst(child);
    });
  }
  return result;
}
