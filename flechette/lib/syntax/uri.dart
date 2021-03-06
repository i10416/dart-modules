import 'package:flechette/flechette.dart';

// ignore: avoid_classes_with_only_static_members
class UriX {
  static Result<Uri> attemptParse(String uri) {
    final u = Uri.tryParse(uri);
    if (u == null) {
      return Result.failure(UriFailures.parseFailure, 'Invalid URI');
    } else {
      return Result.success(u);
    }
  }
}

class UriFailures {
  static const String parseFailure = 'INVALID_URI_FAILURE';
}
