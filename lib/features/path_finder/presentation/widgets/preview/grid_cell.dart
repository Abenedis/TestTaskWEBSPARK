import 'package:flutter/material.dart';

import '../../../domain/entities/cell_type.dart';
import '../../../domain/entities/coordinate.dart';
import '../../utils/cell_type_style.dart';

class GridCell extends StatelessWidget {
  final Coordinate coordinate;
  final CellType type;

  const GridCell({super.key, required this.coordinate, required this.type});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: type.backgroundColor,
        border: Border.all(color: Colors.black26, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: FittedBox(
          // на великих полях текст зменшується, щоб вміститися в комірку
          fit: BoxFit.scaleDown,
          child: Text(
            '${coordinate.x}.${coordinate.y}',
            style: TextStyle(color: type.textColor),
          ),
        ),
      ),
    );
  }
}
