import 'package:flutter/rendering.dart';

class RenderGap extends RenderBox {
  RenderGap({
    required double mainAxisExtent,
    double crossAxisExtent = 0,
    Axis? fallbackDirection,
    Color? color,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection;

  final Paint _paint = Paint();

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  double get crossAxisExtent => _crossAxisExtent;
  double _crossAxisExtent;
  set crossAxisExtent(double value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  Axis? _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Axis? get _resolvedDirection {
    final parentNode = parent;
    if (parentNode is RenderFlex) {
      return parentNode.direction;
    }
    return fallbackDirection;
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMinIntrinsicWidth(height),
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMaxIntrinsicWidth(height),
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMinIntrinsicHeight(width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMaxIntrinsicHeight(width),
    );
  }

  double _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final Axis? direction = _resolvedDirection;
    if (direction == axis) {
      return mainAxisExtent;
    }
    if (crossAxisExtent.isFinite) {
      return crossAxisExtent;
    }
    return compute();
  }

  Size _sizeForDirection(Axis direction) {
    if (direction == Axis.horizontal) {
      return Size(mainAxisExtent, crossAxisExtent);
    }
    return Size(crossAxisExtent, mainAxisExtent);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _resolvedDirection;
    if (direction == null) {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget '
        'or its fallbackDirection must not be null',
      );
    }

    return constraints.constrain(_sizeForDirection(direction));
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Color? color = this.color;
    if (color == null) {
      return;
    }
    _paint.color = color;
    context.canvas.drawRect(offset & size, _paint);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}
