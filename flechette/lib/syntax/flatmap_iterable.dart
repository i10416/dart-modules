extension IterableCollectionsOps<T> on Iterable<T> {
  Iterable<R> flatMap<R>(Iterable<R> Function(T) f) =>
      fold<Iterable<R>>(<R>[], (acc, element) => [...acc, ...f(element)]);
}
