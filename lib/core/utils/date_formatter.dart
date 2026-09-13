import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays == 0 && now.day == dateTime.day) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (difference.inDays == 1 ||
        (difference.inDays == 0 && now.day != dateTime.day)) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  static String formatBubbleTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}
