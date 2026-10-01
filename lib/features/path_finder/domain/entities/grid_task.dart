import 'package:equatable/equatable.dart';

import 'coordinate.dart';
import 'grid_field.dart';

/// Одне завдання з API: поле, стартова та кінцева точки.
/// [id] потрібен, щоб сервер зіставив надісланий результат із завданням.
class GridTask extends Equatable {
  final String id;
  final GridField field;
  final Coordinate start;
  final Coordinate end;

  const GridTask({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [id, field, start, end];
}
