import 'package:flechette/syntax/flatmap_iterable.dart';
import 'package:test/test.dart';

void main() {
  test('flatmap', () {
    final l =
        [1, 2, 3, 4, 5].flatMap((p0) => Iterable<int>.generate(p0, (i) => i));
    expect(l,
        containsAllInOrder(<int>[0, 0, 1, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 4]));
  });
}
