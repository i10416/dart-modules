import 'package:flechette/syntax/flatmap_optional.dart';
import 'package:test/test.dart';

void main() {
  test('flatmap optional', () {
    final l = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        .flatMap((p0) => p0 % 2 == 0 ? p0 : null);
    expect(l, containsAllInOrder(<int>[2, 4, 6, 8, 10]));
  });
}
