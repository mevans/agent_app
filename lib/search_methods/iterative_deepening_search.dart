import 'dart:collection';

import '../models/blockworld.dart';
import '../models/search_result.dart';

SearchResult iterativeDeepeningSearch(Blockworld startState) {
  SearchResult result = SearchResult(searchMethod: "Iterative Deepening Search");
  ListQueue<Blockworld> stack = ListQueue.from([Blockworld.close()]);
  // Max depth variable keeps track of the max depth the 'dfs' can look through
  int maxDepth = 0;
  int nodesExpanded = 0;

  while (stack.isNotEmpty) {
    Blockworld state = stack.removeFirst();
    if (state.isFinishState()) {
      result.nodesExpanded = nodesExpanded;
      result.finalState = state;
      return result;
    }
    // Similar to the dfs, however only add the children to the stack if the current depth is less than the max
    if (state.findDepth() < maxDepth) {
      nodesExpanded++;
      state.generateChildren().forEach((child) {
        stack.addFirst(child);
      });
    }
    /* If the stack is empty ie. every node has been search at the current depth, start again from the top and increase
     the maxDepth*/
    if (stack.isEmpty) {
      stack.add(startState);
      maxDepth++;
    }
  }
  return result;
}
