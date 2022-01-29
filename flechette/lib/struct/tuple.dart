/// represent a pair of values of type T and S
///
/// ```dart
/// // create tuple
/// final tpl = $(1,'a');
/// ```
///
class $<T, S> {
  const $(this.$0, this.$1);
  final T $0;
  final S $1;

  @override
  String toString() => '(${$0},${$1})';

  @override
  bool operator ==(Object other) =>
      other is $ && $0 == other.$0 && $1 == other.$1;

  @override
  int get hashCode => $0.hashCode ^ $1.hashCode;
}

extension TupleOps<T, S> on $<T, S> {
  /// returns new tuple swapping left one with right one.
  $<S, T> swap() => $($1, $0);

  /// apply function f on left value and g on right value and return tuple.
  $<P, Q> bimap<P, Q>(P Function(T) f, Q Function(S) g) => $(f($0), g($1));
  //  applies function f(t,s) on tuple value and returns value of type P
  P mapN<P>(P Function(T, S) f) => f($0, $1);
}
