import '../../domain/entities/grid_field.dart';
import '../../domain/entities/grid_task.dart';
import 'coordinate_model.dart';

abstract final class GridTaskModel {
  static GridTask fromJson(Map<String, dynamic> json) {
    return GridTask(
      id: json['id'] as String,
      field: GridField(List<String>.from(json['field'] as List)),
      start: CoordinateModel.fromJson(json['start'] as Map<String, dynamic>),
      end: CoordinateModel.fromJson(json['end'] as Map<String, dynamic>),
    );
  }
}
