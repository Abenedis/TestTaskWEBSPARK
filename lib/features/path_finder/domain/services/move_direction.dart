import '../entities/coordinate.dart';

/// Напрямки руху фігури: по рядку, стовпчику та діагоналях.
enum MoveDirection {
  up(0, -1),
  down(0, 1),
  left(-1, 0),
  right(1, 0),
  upLeft(-1, -1),
  upRight(1, -1),
  downLeft(-1, 1),
  downRight(1, 1);

  final int dx;
  final int dy;

  const MoveDirection(this.dx, this.dy);

  Coordinate applyTo(Coordinate from) => from.shift(dx, dy);
}
