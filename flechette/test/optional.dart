import 'package:flechette/syntax/optional.dart';
import 'package:test/test.dart';

void main() {
  group('optional', () {
    group('map', () {
      test('only some', () {
        const a = 1;
        const int? b = null;
        expect(a.map((i) => i * 2), 2);
        expect(b.map((p0) => p0 * 2), null);
      });
    });
    group('foreach', () {
      test('run only for some', () {
        const a = 1;
        const int? b = null;
        int? c;
        int? d = 1;
        a.foreach((i) {
          c = i;
        });
        b.foreach((p0) {
          d = p0;
        });
        expect(c, a);
        expect(d, 1);
      });
    });
    group('fold', () {
      test('', () {
        const int? a = 1;
        const int? b = null;

        final res1 = a.fold(() => 'none!')((e) => (e * 100).toString());
        final res2 = b.fold(() => 'none!')((e) => (e * 100).toString());
        expect(res1, '100');
        expect(res2, 'none!');
      });
    });
  });
}
