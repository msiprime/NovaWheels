import 'package:intl/intl.dart';

/// Extension to make displaying [DateTime] objects simpler.
extension DateTimeEx on DateTime {
  /// Converts [DateTime] into a MMMM dd, yyyy [String].
  String get mDY {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  /// convert to December 14, 2021 12:00 AM
  String get mDYhms {
    return DateFormat('MMMM d, yyyy hh:mm a').format(this);
  }
}
