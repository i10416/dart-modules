extension OptionalCollectionsOps<T> on Iterable<T> {
  /// flatMap map elements of an iterable into iterable of optional,
  /// then collect non-null values into iterable.
  ///
  /// example
  /// ```dart
  /// [1,2,3,4,5].flatMap((element) =>  element %2 == 0 ? element : null ) // [2,4];
  /// ```
  ///
  Iterable<R> flatMap<R>(R? Function(T) f) =>
      fold<Iterable<R>>(<R>[], (acc, element) {
        final r = f(element);
        if (r == null) {
          return acc;
        } else {
          return [...acc, r];
        }
      });
}
