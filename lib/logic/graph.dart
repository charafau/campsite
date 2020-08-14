import 'dart:collection';

class Graph {
  final List<Edge> _edges;
  Set<int> _unvisitedVertices;
  Set<int> _visitedVertices;

  List<int> _distanceForVertices;
  List<int> _previousVertices;
  int _startVertex;

  final int _infinite = 9999;

  List<Edge> get edges => _edges;

  Graph(this._edges, this._startVertex) {
    _unvisitedVertices = HashSet();
    _unvisitedVertices.addAll(_edges.map((e) => e.to));
    _unvisitedVertices.addAll(_edges.map((e) => e.from));
    _visitedVertices = HashSet();
    _distanceForVertices = List.filled(_unvisitedVertices.length, _infinite);
    _distanceForVertices[_startVertex] = 0;
    _previousVertices = List.filled(_unvisitedVertices.length, -1);
    _calculatePaths();
  }

  factory Graph.campsite() {
    return Graph([
      Edge(from: 0, to: 1, distance: 1),
      Edge(from: 1, to: 2, distance: 1),
      Edge(from: 1, to: 13, distance: 1),
      Edge(from: 2, to: 3, distance: 1),
      Edge(from: 13, to: 16, distance: 1),
      Edge(from: 3, to: 4, distance: 1),
      Edge(from: 16, to: 15, distance: 1),
      Edge(from: 15, to: 14, distance: 1),
      Edge(from: 14, to: 8, distance: 1),
      Edge(from: 13, to: 12, distance: 1),
      Edge(from: 4, to: 5, distance: 1),
      Edge(from: 12, to: 11, distance: 1),
      Edge(from: 11, to: 10, distance: 1),
      Edge(from: 5, to: 6, distance: 1),
      Edge(from: 10, to: 9, distance: 1),
      Edge(from: 6, to: 7, distance: 1),
      Edge(from: 9, to: 8, distance: 1),
      Edge(from: 7, to: 8, distance: 1),
    ], 0);
  }

  void _calculatePaths() {
    while (_unvisitedVertices.isNotEmpty) {
      int closestVertex = _findClosestVertex();

      _visitedVertices.add(closestVertex);
      _unvisitedVertices.remove(closestVertex);

      final neighbours = _findAllNeighbours(closestVertex);

      neighbours.forEach((edge) {
        final currentNeighbour =
            edge.from == closestVertex ? edge.to : edge.from;
        if (_unvisitedVertices.contains(currentNeighbour)) {
          if (_distanceForVertices[currentNeighbour] >
              _distanceForVertices[closestVertex] + edge.distance) {
            _distanceForVertices[currentNeighbour] =
                _distanceForVertices[closestVertex] + edge.distance;
            _previousVertices[currentNeighbour] = closestVertex;
          }
        }
      });
    }
  }

  List<int> getShortestPath(int end) {
    List<int> path = [];

    int currentVertex = end;
    while (currentVertex != -1) {
      path.add(currentVertex);
      currentVertex = _previousVertices[currentVertex];
    }

    return path;
  }

  int _findClosestVertex() {
    int currentLowestDistance = _infinite;
    int currentClosestVertex = -1;

    _unvisitedVertices.forEach((vertex) {
      if (_distanceForVertices[vertex] < currentLowestDistance) {
        currentLowestDistance = _distanceForVertices[vertex];
        currentClosestVertex = vertex;
      }
    });

    return currentClosestVertex;
  }

  List<Edge> _findAllNeighbours(int vertex) {
    return _edges
        .where((element) => element.to == vertex || element.from == vertex)
        .toList();
  }

  @override
  String toString() {
    return 'Graph{edges: $_edges, startVertex: $_startVertex}';
  }
}

class Edge {
  final int from;
  final int to;
  final int distance;

  Edge({this.from, this.to, this.distance});

  @override
  String toString() {
    return 'Edge{from: $from, to: $to, distance: $distance}';
  }
}
