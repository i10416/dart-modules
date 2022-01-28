import '../struct/tuple.dart';

extension CollectionOps<T> on Iterable<T> {
  Iterable<T> sorted([int Function(T, T)? f]) {
    final clone = [...this]..sort(f);
    return clone;
  }

  Map<S, Iterable<T>> groupBy<S>(S Function(T) f) {
    final m = <S, Iterable<T>>{};
    return fold<Map<S, Iterable<T>>>(m, (acc, element) {
      final key = f(element);
      return acc.containsKey(key)
          ? {
              ...acc,
              key: [...acc[key]!, element]
            }
          : {
              ...acc,
              key: [element]
            };
    });
  }

  // [0,1,2,3,4,5,...] => [(0,1),(1,2),(2,3),(3,4),(4,5),...]
  Iterable<$<T, T>> slide() =>
      fold<$<Iterable<$<T, T>>, T?>>($(Iterable<$<T, T>>.empty(), null),
          (acc, element) {
        if (acc.$1 == null) {
          return $(acc.$0, element);
        } else {
          return $([...acc.$0, $(acc.$1!, element)], element);
        }
      }).$0;

  Iterable<T> intersect<R extends T>(R r) => List.generate(
      length + length - 1, (i) => i % 2 == 0 ? elementAt(i ~/ 2) : r);

  Iterable<$<T, int>> get zipWithIndex => fold<$<List<$<T, int>>, int>>(
      const $([], 0),
      (acc, elm) => $([...acc.$0, $(elm, acc.$1)], acc.$1 + 1)).$0;

  List<$<T, S>> zip<S>(Iterable<S> t) {
    if (t.length > length) {
      return List<$<T, S>>.generate(
          length, (i) => $(elementAt(i), t.elementAt(i)));
    } else {
      return List<$<T, S>>.generate(
          t.length, (i) => $(elementAt(i), t.elementAt(i)));
    }
  }

  int count(bool Function(T) f) =>
      fold(0, (acc, element) => f(element) ? acc + 1 : acc);
  $<Iterable<T>, Iterable<T>> splitAt(int n) => $(take(n), skip(n));
}
