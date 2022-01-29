extension IterableOptionalOps<T> on Iterable<T?> {
  /// flatten iterable of nullable into iterable of non-nullable
  ///
  /// example
  /// ```dart
  /// [1,null,2,null,3,null].flatten() // => [1,2,3];
  /// ```
  ///
  Iterable<T> flatten() => whereType<T>();
}
