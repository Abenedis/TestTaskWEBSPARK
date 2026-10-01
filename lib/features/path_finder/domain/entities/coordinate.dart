import 'package:equatable/equatable.dart';

/// Координата комірки: x — стовпчик, y — рядок (відлік з верхнього лівого кута).
class Coordinate extends Equatable {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  Coordinate shift(int dx, int dy) => Coordinate(x + dx, y + dy);

  @override
  String toString() => '($x.$y)';

  @override
  List<Object?> get props => [x, y];
}
