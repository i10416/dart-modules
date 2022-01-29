import 'dart:math';

import 'package:flechette/struct/tuple.dart';
import 'package:flechette/syntax//collections.dart';
import 'package:test/test.dart';

void main() {
  group('collections', () {
    group('Iterable', () {
      group('sorted', () {
        test('returns new sorted list', () {
          final l1 = [1, 100, 20, 10, 90];
          final l2 = [1, 100, 20, 10, 90];
          final m = l1.sorted();
          final sorted = [1, 10, 20, 90, 100];
          for (var i = 0; i < l1.length; i++) {
            expect(l1.elementAt(i), l2[i]);
          }
          for (var i = 0; i < m.length; i++) {
            expect(m.elementAt(i), sorted[i]);
          }
        });
      });
      group('count', () {
        test('returns count of items which match predicates', () {
          final l = [1, 2, 3, 4, 5];
          expect(l.count((p0) => p0 > 3), 2);
        });
      });
      group('splitAt(n)', () {
        test('returns tuple of list', () {
          final l = [1, 2, 3, 4, 5].splitAt(3);
          final m = [1, 2, 3, 4, 5].splitAt(9);
          expect(l.$0, containsAllInOrder(<int>[1, 2, 3]));
          expect(l.$1, containsAllInOrder(<int>[4, 5]));
          expect(m.$0, containsAllInOrder(<int>[1, 2, 3, 4, 5]));
          expect(m.$1.isEmpty, true);
        });
      });
      group('groupBy', () {
        test('group elements by key which matches predicate', () {
          final l = Iterable<int>.generate(100, (n) => n);
          final g = l.groupBy((p0) => p0 % 2 == 0);
          expect(g[true]!.length == 50, true);
          expect(g[false]!.length == 50, true);
          expect(g[true]!,
              containsAllInOrder(Iterable<int>.generate(50, (n) => n * 2)));
          expect(g[false]!,
              containsAllInOrder(Iterable<int>.generate(50, (n) => n * 2 + 1)));
        });
      });
      group('zipWithIndex', () {
        test('returns list element tupled with index', () {
          final l = Iterable<int>.generate(
              100, (n) => Random(n + 1).nextInt(10 * (n + 1)));
          final zipped = l.zipWithIndex;
          for (var i = 0; i < l.length; i++) {
            expect(zipped.elementAt(i).$1, i);
          }
        });
      });
      group('intersect', () {
        test('insert element every 1 step', () {
          final l = [1, 2, 3, 4, 5];
          final m = [1, 2, 3, 4];
          final l1 = l.intersect(-1);
          final m1 = m.intersect(-1);
          expect(l1, containsAllInOrder(<int>[1, -1, 2, -1, 3, -1, 4, -1, 5]));
          expect(m1, containsAllInOrder(<int>[1, -1, 2, -1, 3, -1, 4]));
        });
      });
      group('slide', () {
        test('collect element as pair', () {
          final l = [1, 2, 3, 4, 5];
          expect(
              l.slide(),
              containsAllInOrder(<$<int, int>>[
                const $(1, 2),
                const $(2, 3),
                const $(3, 4),
                const $(4, 5)
              ]));
        });
      });
      group('zip', () {
        test('zip two lists of the same length into one', () {
          final l = [1, 2, 3, 4, 5];
          final m = ['a', 'b', 'c', 'd', 'e'];
          final z = l.zip(m);
          for (var i = 0; i < l.length; i++) {
            expect(z.elementAt(i), $(l.elementAt(i), m.elementAt(i)));
          }
        });
        test(
            'zip two lists of the different length into a list of the same length as shorter one',
            () {
          final l = [1, 2, 3, 4];
          final m = ['a', 'b', 'c', 'd', 'e', 'f'];
          final z = l.zip(m);
          expect(z.length, 4);
          for (var i = 0; i < l.length; i++) {
            expect(z.elementAt(i), $(l.elementAt(i), m.elementAt(i)));
          }
          final x = m.zip(l);
          expect(x.length, 4);
          for (var i = 0; i < l.length; i++) {
            expect(x.elementAt(i), $(m.elementAt(i), l.elementAt(i)));
          }
        });
      });
    });
    group('map', () {
      group('updateWith', () {
        test('update map according to given function', () {
          final map = <String, int>{'a': 1, 'b': 2, 'c': 3};
          final map2 = map.updateWith('a')((e) => e == null ? 0 : e * 10);
          expect(map['a'], 1);
          expect(map2['a'], 10);
          final map3 = map.updateWith('a')((e) => null);
          expect(map3['a'], null);
          final map4 = map.updateWith('d')((e) => e == null ? 4 : null);
          expect(map4['d'], 4);
        });
      });
    });
  });
}
