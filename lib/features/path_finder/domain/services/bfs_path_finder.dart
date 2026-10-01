import 'dart:collection';

import '../entities/coordinate.dart';
import '../entities/grid_field.dart';
import 'move_direction.dart';
import 'path_finder.dart';

/// Пошук у ширину. Усі переходи мають однакову вагу,
/// тому перший знайдений шлях до кінцевої точки — найкоротший.
class BfsPathFinder implements PathFinder {
  const BfsPathFinder();

  @override
  List<Coordinate> findPath(GridField field, Coordinate start, Coordinate end) {
    if (!field.isWalkable(start) || !field.isWalkable(end)) return const [];

    final queue = Queue<Coordinate>()..add(start);
    // для кожної відвіданої комірки зберігаємо, з якої ми в неї прийшли
    final cameFrom = <Coordinate, Coordinate?>{start: null};

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current == end) return _restorePath(cameFrom, end);

      for (final direction in MoveDirection.values) {
        final next = direction.applyTo(current);
        if (cameFrom.containsKey(next) || !field.isWalkable(next)) continue;

        cameFrom[next] = current;
        queue.add(next);
      }
    }

    return const [];
  }

  List<Coordinate> _restorePath(
    Map<Coordinate, Coordinate?> cameFrom,
    Coordinate end,
  ) {
    final path = <Coordinate>[];
    Coordinate? step = end;
    while (step != null) {
      path.add(step);
      step = cameFrom[step];
    }
    return path.reversed.toList();
  }
}
