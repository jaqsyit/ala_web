String normalizeDateTime(String originalDateTimeString) {
  DateTime originalDateTime = DateTime.parse(originalDateTimeString);

  String formattedDateTime =
      '${originalDateTime.hour.toString().padLeft(2, '0')}:${originalDateTime.minute.toString().padLeft(2, '0')}\n'
      '${originalDateTime.day.toString().padLeft(2, '0')}.${originalDateTime.month.toString().padLeft(2, '0')}.${originalDateTime.year % 100}';

  return formattedDateTime;
}
