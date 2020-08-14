import 'package:campsite/logic/graph.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should find shortest path', () {
    final graph = Graph(<Edge>[
      Edge(from: 0, to: 1, distance: 6),
      Edge(from: 0, to: 3, distance: 1),
      Edge(from: 3, to: 1, distance: 2),
      Edge(from: 3, to: 4, distance: 1),
      Edge(from: 1, to: 4, distance: 2),
      Edge(from: 1, to: 2, distance: 5),
      Edge(from: 4, to: 2, distance: 5),
    ], 0);

    final path = graph.getShortestPath(2);
    expect(path, [2, 4, 3, 0]);
  });

  test('should return campsite shortest path to 15 stop', () {
    final graph = Graph.campsite();
    expect(graph.getShortestPath(15), [15,16,13,1,0]);
  });
}
