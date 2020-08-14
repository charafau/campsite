import 'package:campsite/features/main/domain/model/group_path.dart';
import 'package:campsite/logic/graph.dart';
import 'package:flutter/material.dart';

class CampsiteMap extends StatelessWidget {
  final Graph graph;

  const CampsiteMap({Key key, this.graph}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: 500,
        height: 600,
        child: CustomPaint(
          painter: CampsiteMapPainter(graph),
        ),
      ),
    );
  }
}

class CampsiteMapPainter extends CustomPainter {
  final int padding = 100;
  final Graph graph;

  final Map<int, _Station> stations = {
    0: _Station(0, 3, 6),
    1: _Station(1, 3, 5),
    2: _Station(2, 4, 5),
    3: _Station(3, 5, 4),
    4: _Station(4, 5, 3),
    5: _Station(5, 5, 2),
    6: _Station(6, 5, 1),
    7: _Station(7, 4, 0),
    8: _Station(8, 2, 0),
    9: _Station(9, 1, 0),
    10: _Station(10, 0, 2),
    11: _Station(11, 0, 3),
    12: _Station(12, 0, 4),
    13: _Station(13, 1, 5),
    14: _Station(14, 2, 1),
    15: _Station(15, 2, 3),
    16: _Station(16, 2, 4),
  };

  final GroupPath selectedGroup;
  final Set<int> selectedGroupPath;

  CampsiteMapPainter(this.graph, {this.selectedGroup})
      : selectedGroupPath =
            selectedGroup != null ? selectedGroup.verticesPath.toSet() : null;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    _drawBackground(canvas, rect);

    final multiplierX = (size.width / 8);
    final multiplierY = (size.height / 8);

    _drawPaths(multiplierX, multiplierY, canvas);

    stations.forEach((key, point) {
      _drawStations(point, multiplierX, multiplierY, canvas);

      _drawText(point, multiplierX, multiplierY, canvas);
    });
  }

  void _drawBackground(Canvas canvas, Rect rect) {
    canvas.drawRect(rect, Paint()..color = Colors.green.shade800);
  }

  void _drawStations(
      _Station point, double multiplierX, double multiplierY, Canvas canvas) {
    var offset = Offset(point.x.toDouble() * multiplierX + padding,
        point.y.toDouble() * multiplierY + padding);
    var color =
        (selectedGroupPath != null && selectedGroupPath.contains(point.id))
            ? Colors.red
            : Colors.yellow;
    canvas.drawCircle(offset, 14, Paint()..color = color);
  }

  void _drawText(
      _Station point, double multiplierX, double multiplierY, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        text: '${point.id}');
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);

    var textOffset = Offset(point.x.toDouble() * multiplierX - 6 + padding,
        point.y.toDouble() * multiplierY - 8 + padding);
    tp.layout();
    tp.paint(canvas, textOffset);
  }

  void _drawPaths(double multiplierX, double multiplierY, Canvas canvas) {
    graph.edges.forEach((edge) {
      var offsetFrom = Offset(
          stations[edge.from].x.toDouble() * multiplierX + padding,
          stations[edge.from].y.toDouble() * multiplierY + padding);

      var offsetTo = Offset(
          stations[edge.to].x.toDouble() * multiplierX + padding,
          stations[edge.to].y.toDouble() * multiplierY + padding);
      canvas.drawLine(
        offsetFrom,
        offsetTo,
        Paint()
          ..color = Colors.brown
          ..strokeWidth = 4,
      );
    });
  }

  @override
  bool shouldRepaint(CampsiteMapPainter oldDelegate) =>
      stations != oldDelegate.stations;
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class _Station {
  final int id;
  final int x;
  final int y;

  _Station(this.id, this.x, this.y);
}
