extension OptionalCollectionsOps<T> on Iterable<T> {
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
