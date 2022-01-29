import 'package:flechette/syntax/flatten_iterable.dart';
import 'package:flechette/syntax/flatten_optional.dart';
import 'package:test/test.dart';

void main() {
  test('flatten iterable', () {
    final l = <Iterable<int>>[
      [1, 2],
      [3, 4],
      [5, 6],
      [7, 8]
    ].flatten();
    expect(
        l,
        containsAllInOrder(<int>[
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
        ]));
  });
  test('flatten optional', () {
    final m = <int?>[1, null, 2, null, 3, null, 4, null, 5, null].flatten();
    expect(m, containsAllInOrder(<int>[1, 2, 3, 4, 5]));
  });
}
