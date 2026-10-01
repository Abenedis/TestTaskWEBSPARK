import '../../domain/entities/coordinate.dart';

/// Перетворення координат між JSON та доменною сутністю.
/// Не наслідує [Coordinate], бо Equatable враховує тип при порівнянні.
abstract final class CoordinateModel {
  // у swagger координати описані як number, тому приводимо до int явно
  static Coordinate fromJson(Map<String, dynamic> json) {
    return Coordinate((json['x'] as num).toInt(), (json['y'] as num).toInt());
  }

  static Map<String, dynamic> toJson(Coordinate c) => {'x': c.x, 'y': c.y};
}
