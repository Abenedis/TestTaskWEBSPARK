import 'package:equatable/equatable.dart';

import 'coordinate.dart';

/// Ігрове поле. Кожен рядок — це рядок сітки, де `X` позначає заблоковану комірку.
class GridField extends Equatable {
  static const blockedSymbol = 'X';

  final List<String> rows;

  const GridField(this.rows);

  int get height => rows.length;

  int get width => rows.isEmpty ? 0 : rows.first.length;

  bool contains(Coordinate c) =>
      c.y >= 0 && c.y < height && c.x >= 0 && c.x < rows[c.y].length;

  bool isBlocked(Coordinate c) => rows[c.y][c.x] == blockedSymbol;

  bool isWalkable(Coordinate c) => contains(c) && !isBlocked(c);

  @override
  List<Object?> get props => [rows];
}
