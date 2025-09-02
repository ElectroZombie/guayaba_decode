import 'package:flutter/material.dart';

class IconModel {
  IconData _icon = Icons.check_box;
  Color _color = Colors.green;

  IconModel({required bool active}) {
    if (!active) {
      deactivate();
    }
  }

  void activate() {
    _icon = Icons.check_box;
    _color = Colors.green;
  }

  void deactivate() {
    _icon = Icons.cancel;
    _color = Colors.red;
  }

  IconData getIcon() {
    return _icon;
  }

  Color getColor() {
    return _color;
  }
}
