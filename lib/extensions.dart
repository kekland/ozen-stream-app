import 'package:flutter/material.dart';

extension Theming on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return this.theme.textTheme;
  }
}