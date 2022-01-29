extension IterableCollectionsOps<T> on Iterable<T> {
  /// flatMap map elements of an iterable into iterable of iterable,
  /// then flatten iterable of iterable value into iterable of values.
  ///
  /// example
  /// ```dart
  /// [1,2,3,4,5].flatMap((element) =>  [element,element,element]) // [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5];
  /// ```
  ///
  Iterable<R> flatMap<R>(Iterable<R> Function(T) f) =>
      fold<Iterable<R>>(<R>[], (acc, element) => [...acc, ...f(element)]);
}
