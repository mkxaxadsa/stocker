
extension FormatExt on DateTime {
  DateTime get ymd => DateTime(year,month,day);
  String get simpleFormat => "$year-${month.toString().padLeft(2,'0')}-${day.toString().padLeft(2,'0')}";
  String get simpleReversedDotFormat => "${day.toString().padLeft(2,'0')}.${month.toString().padLeft(2,'0')}.$year";
  String get simpleFormat2 => "$simpleReversedDotFormat ${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}";
} 