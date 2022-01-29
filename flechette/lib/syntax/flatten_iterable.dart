extension IterableIterableOps<T> on Iterable<Iterable<T>> {
  /// flatten iterable of iterable into iterable
  ///
  /// example
  /// ```dart
  /// [[1,2,3],[4,5,6],[7,8,9]].flatten() // => [1,2,3,4,5,6,7,8,9]
  /// ```
  ///
  Iterable<T> flatten() =>
      fold<Iterable<T>>([], (acc, element) => [...acc, ...element]);
}
