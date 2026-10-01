import '../entities/coordinate.dart';
import '../entities/grid_field.dart';

abstract class PathFinder {
  /// Повертає послідовність координат від [start] до [end] включно.
  /// Якщо шляху не існує — порожній список.
  List<Coordinate> findPath(GridField field, Coordinate start, Coordinate end);
}
