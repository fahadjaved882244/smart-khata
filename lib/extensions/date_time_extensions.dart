import 'package:intl/intl.dart';

extension DateTimeX on DateTime? {
  String? get formattedDateTime {
    if (this == null) return null;
    final fDate = formattedDate;
    final fTime = DateFormat('hh:mm a').format(this!);
    return "$fDate  $fTime";
  }

  String? get formattedDate {
    final now = DateTime.now();
    if (this == null) return null;
    final x = DateTime(this!.year, this!.month, this!.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (x == 0) {
      return "Today";
    } else if (x == 1) {
      return "Tomorrow";
    } else if (x == -1) {
      return "Yesterday";
    } else {
      return DateFormat.yMMMd().format(this!);
    }
  }
}
