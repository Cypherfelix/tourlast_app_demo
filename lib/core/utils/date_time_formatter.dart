import 'package:intl/intl.dart';

/// Utility class for formatting dates and times for flight displays.
class DateTimeFormatter {
  DateTimeFormatter._();

  /// Parse ISO 8601 date-time string to DateTime.
  static DateTime? parseIsoDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    try {
      return DateTime.parse(dateTimeString);
    } catch (_) {
      return null;
    }
  }

  /// Format time for display (e.g., "12:50").
  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Format date for display (e.g., "21 Dec").
  static String formatShortDate(DateTime? dateTime) {
    if (dateTime == null) return '--';
    return DateFormat('d MMM').format(dateTime);
  }

  /// Format duration from minutes string (e.g., "55" → "55m" or "1h 30m").
  static String formatDuration(String? durationMinutes) {
    if (durationMinutes == null || durationMinutes.isEmpty) return '--';
    try {
      final minutes = int.parse(durationMinutes);
      if (minutes < 60) {
        return '${minutes}m';
      }
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '${hours}h';
      }
      return '${hours}h ${remainingMinutes}m';
    } catch (_) {
      return durationMinutes;
    }
  }

  /// Calculate time difference between two dates.
  static Duration? calculateDuration(DateTime? departure, DateTime? arrival) {
    if (departure == null || arrival == null) return null;
    return arrival.difference(departure);
  }
}
