import 'package:flechette/flechette.dart';

extension URIOps on Uri {
  Result<Uri> attemptParse(String uri) {
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
