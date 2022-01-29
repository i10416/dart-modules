import 'package:flechette/flechette.dart';

// ignore: avoid_classes_with_only_static_members
class DateTimeX {
  static Result<DateTime> attemptParse(String uri) {
    final u = DateTime.tryParse(uri);
    if (u == null) {
      return Result.failure(UriFailures.parseFailure, 'Invalid URI');
    } else {
      return Result.success(u);
    }
  }
}

class DateTimeFailures {
  static const String parseFailure = 'INVALID_DATETIME_FAILURE';
}
