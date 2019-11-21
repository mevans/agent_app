import '../models/blockworld.dart';
import '../models/search_result.dart';

SearchResult randomSearch(Blockworld startState) {
  SearchResult result = SearchResult(searchMethod: "Random Search");
  Blockworld state = startState;
  int nodesExpanded = 0;
  while (!startState.isFinishState()) {
    if (state.isFinishState()) {
      result.finalState = state;
      result.nodesExpanded = nodesExpanded;
      return result;
    }
    // Select the first item from the list of randomised children
    state = state.generateChildren(randomise: true).first;
    nodesExpanded++;
  }
  return result;
}
