import 'package:flechette/flechette.dart';
import 'package:test/test.dart';

void main() {
  group('result', () {
    group('flatMap', () {
      test('flatten result', () {
        final s = Result.success(1);
        final f = Result<int>.failure('OUTSIDE_FAILURE', '');
        final fms = s.flatMap((i) => Result.success(2 * i));
        final fmf = s.flatMap((i) => Result<int>.failure('INSIDE_FAILURE', ''));
        final nope1 = f.flatMap((i) => Result.success(i));
        final nope2 =
            f.flatMap((i) => Result<int>.failure('INSIDE_FAILURE', ''));
        expect(fms.isSuccess, true);
        expect(fms.value!, 2);
        expect(fmf.isSuccess, false);
        expect(fmf.errorKey, 'INSIDE_FAILURE');
        expect(nope1.isSuccess, false);
        expect(nope1.errorKey, 'OUTSIDE_FAILURE');
        expect(nope2.errorKey, 'OUTSIDE_FAILURE');
      });
    });
  });
}
