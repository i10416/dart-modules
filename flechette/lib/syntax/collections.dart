import 'package:flechette/struct/tuple.dart';

extension CollectionOps<T> on Iterable<T> {
  /// returns new sorted iterable.
  Iterable<T> sorted([int Function(T, T)? f]) {
    final clone = [...this]..sort(f);
    return clone;
  }

  /// safely access first element of list that may be empty.
  T? get headOption => isEmpty ? null : first;

  /// safely access last element of list that may be empty.
  T? get lastOption => isEmpty ? null : last;

  /// returns Map<S,Iterable<T>> according to function f which extract key from value of type T.
  ///
  /// example
  /// ```dart
  /// [1,2,3,4,5].groupBy((element)=> element % 2) // {true: [2,4],false: [1,3,5]};
  /// ```
  ///
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

  /// returns a list of list of length up to n.
  /// example
  ///
  /// ```dart
  /// [0,1,2,3,4,5,6,7,8,9,10].chunk(3) // =>[[0,1,2],[3,4,5],[6,7,8],[9,10]]
  /// ```
  ///
  Iterable<Iterable<T>> chunk(int n) =>  n <= length ? Iterable<Iterable<T>>.generate(length % n == 0 ? length ~/ n : (length ~/ n) +1,(k)=> skip(k*n).take(n)) : [this];

  /// return sublist of range [from,to)
  ///
  /// example
  ///
  /// ```dart
  /// [a,b,c,d,e,f,g,h,i,j,k].slice(3,6) // => [d,e,f]
  /// ```
  ///
  Iterable<T> slice(int from,[int? to]) {
    if(to == null){
      return skip(from);
    }else {
      return skip(from).take(to - from);
    }
  }

  /// returns a list of pairs of values slided by 1.
  /// example
  /// ```dart
  /// [0,1,2,3,4,5,...].slide() //  => [(0,1),(1,2),(2,3),(3,4),(4,5),...]
  /// ```
  ///
  Iterable<$<T, T>> slide() =>
      fold<$<Iterable<$<T, T>>, T?>>($(Iterable<$<T, T>>.empty(), null),
          (acc, element) {
        if (acc.$1 == null) {
          return $(acc.$0, element);
        } else {
          return $([...acc.$0, $(acc.$1!, element)], element);
        }
      }).$0;

  ///
  /// /// returns a list of pairs of values slided by n.
  /// example
  /// ```dart
  /// [0,1,2,3,4,5,...].sliding(3) //  => [[0,1,2],[1,2,3],[2,3,4],...]
  /// ```
  ///
  Iterable<Iterable<T>> sliding(int n) =>
      fold<$<Iterable<Iterable<T>>, Iterable<Iterable<T>>>>(
          $(Iterable<Iterable<T>>.empty(), []), (acc, element) {
        if (acc.$1.isEmpty) {
          return $(acc.$0, [
            [element]
          ]);
        } else if (acc.$1.first.length == n - 1) {
          final nxt = acc.$1.skip(1).map((l) => [...l, element]);
          return $([
            ...acc.$0,
            [...acc.$1.first, element]
          ], [
            ...nxt,
            [element]
          ]);
        } else {
          final nxt = acc.$1.map((l) => [...l, element]);
          return $(acc.$0, [
            ...nxt,
            [element]
          ]);
        }
      }).$0;

  /// insert value between each element
  ///
  /// example
  /// ```dart
  /// [1,2,3,4,5].interspace(-1) // [1,-1,2,-1,3,-1,4,-1,5]
  /// ```
  Iterable<T> interspace<R extends T>(R r) => List.generate(
      length + length - 1, (i) => i % 2 == 0 ? elementAt(i ~/ 2) : r);

  /// zip values with index
  ///
  /// example
  ///
  /// ```dart
  ///
  /// ['a','b','c','d','e'].zipWithIndex // => [('a',0),('b',1),('c',2),('d',3),('e',4)]
  /// ```
  ///
  ///
  Iterable<$<T, int>> get zipWithIndex => fold<$<List<$<T, int>>, int>>(
      const $([], 0),
      (acc, elm) => $([...acc.$0, $(elm, acc.$1)], acc.$1 + 1)).$0;

  /// zip corresponding values with values from another iterable.
  /// If one iterable is shorter than the other, it generates iterable of shorter length.
  ///
  /// example
  ///
  /// ```dart
  ///
  /// [1,2,3,4,5].zip('a','b','c') // => [(1,'a'),(2,'b'),(3,'c')]
  List<$<T, S>> zip<S>(Iterable<S> t) {
    if (t.length > length) {
      return List<$<T, S>>.generate(
          length, (i) => $(elementAt(i), t.elementAt(i)));
    } else {
      return List<$<T, S>>.generate(
          t.length, (i) => $(elementAt(i), t.elementAt(i)));
    }
  }

  /// count up elements applying function f returns true.
  int count(bool Function(T) f) =>
      fold(0, (acc, element) => f(element) ? acc + 1 : acc);
  $<Iterable<T>, Iterable<T>> splitAt(int n) => $(take(n), skip(n));
}

extension MapOps<K, V> on Map<K, V> {
  /// update element if key-value pair exists returned value is some.
  ///
  /// remove element if key-value pair exists and returned value is null.
  ///
  /// add element if key-value pair does not exist and returned value is some.
  ///
  /// else it returns the as is.
  ///
  /// In the example below,
  /// if `key` is not 'a','b' ,nor 'c', it returns `{'a':1,'b':2,'c':3,'<key>':4,...}`
  /// if `key` is 'a', it returns `{'a': 100,'b':2,'c':3}`
  /// else it returns {'a': 1, 'b':2,'c': 3}
  /// example
  ///
  /// ```dart
  /// {'a':1,'b':2,'c':3}
  ///   .updateWith(key)((element) => element == null ? 4 : element == 1 ? element * 100  : null);
  ///
  /// ```
  ///
  Map<K, V> Function(V? Function(V?)) updateWith(K k) {
    if (containsKey(k)) {
      return (f) {
        final clone = {...this};
        final deleteIfNull = f(this[k]);
        if (deleteIfNull == null) {
          clone.remove(k);
          return clone;
        } else {
          return {...this, k: deleteIfNull};
        }
      };
    } else {
      return (f) => f(null) == null ? this : <K, V>{...this, k: f(null)!};
    }
  }
}
