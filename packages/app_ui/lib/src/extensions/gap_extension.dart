import 'package:flutter/material.dart' show Widget;
import 'package:gap/gap.dart';

/// An extension that provides gap extension on int and double.
extension GapI on int {
  /// Returns a [Gap] widget with the given [int] value.
  Widget get gap => Gap(toDouble());
}

/// A extension that provides gap extension on int and double.
extension GapD on double {
  /// Returns a [Gap] widget with the given [double] value.
  Widget get gap => Gap(this);
}
