extension IterableIterableOps<T> on Iterable<Iterable<T>> {
  Iterable<T> flatten() =>
      fold<Iterable<T>>([], (acc, element) => [...acc, ...element]);
}
