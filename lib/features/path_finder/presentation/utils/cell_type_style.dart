import 'package:flutter/material.dart';

import '../../domain/entities/cell_type.dart';

/// Кольори комірок згідно з вимогами до екрану перегляду.
extension CellTypeStyle on CellType {
  Color get backgroundColor => switch (this) {
    CellType.start => const Color(0xFF64FFDA),
    CellType.end => const Color(0xFF009688),
    CellType.blocked => const Color(0xFF000000),
    CellType.path => const Color(0xFF4CAF50),
    CellType.empty => const Color(0xFFFFFFFF),
  };

  Color get textColor => switch (this) {
    CellType.blocked || CellType.end => Colors.white,
    _ => Colors.black,
  };
}
