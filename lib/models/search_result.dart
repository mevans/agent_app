import 'blockworld.dart';

// Model to hold information about a searches result
class SearchResult {
  final String searchMethod;
  Blockworld finalState;
  int nodesExpanded;

  SearchResult({this.finalState, this.nodesExpanded, this.searchMethod});

  bool get solutionFound => finalState != null;

  @override
  String toString() {
    return '$searchMethod completed after $nodesExpanded node expansions, with a depth of ${finalState.findDepth()}';
  }

}
