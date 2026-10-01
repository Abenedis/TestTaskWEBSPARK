import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/features/path_finder/domain/entities/coordinate.dart';
import 'package:test_task/features/path_finder/domain/entities/grid_field.dart';
import 'package:test_task/features/path_finder/domain/services/bfs_path_finder.dart';

void main() {
  const finder = BfsPathFinder();

  test('знаходить шлях із прикладу в завданні', () {
    const field = GridField(['.X.', '.X.', '...']);

    final path = finder.findPath(
      field,
      const Coordinate(1, 2),
      const Coordinate(2, 0),
    );

    expect(path, const [Coordinate(1, 2), Coordinate(2, 1), Coordinate(2, 0)]);
  });

  test('рухається по діагоналі, якщо це коротше', () {
    const field = GridField(['XXX.', 'X..X', 'X..X', '.XXX']);

    final path = finder.findPath(
      field,
      const Coordinate(0, 3),
      const Coordinate(3, 0),
    );

    expect(path, hasLength(4));
    expect(path.first, const Coordinate(0, 3));
    expect(path.last, const Coordinate(3, 0));
  });

  test('повертає порожній список, коли шлях заблоковано', () {
    const field = GridField(['.X.', 'XX.', '...']);

    final path = finder.findPath(
      field,
      const Coordinate(0, 0),
      const Coordinate(2, 2),
    );

    expect(path, isEmpty);
  });

  test('шлях з однієї точки, якщо старт збігається з фінішем', () {
    const field = GridField(['..', '..']);

    final path = finder.findPath(
      field,
      const Coordinate(1, 1),
      const Coordinate(1, 1),
    );

    expect(path, const [Coordinate(1, 1)]);
  });
}
