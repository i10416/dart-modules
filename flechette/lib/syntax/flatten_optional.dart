extension IterableOptionalOps<T> on Iterable<T?> {
  Iterable<T> flatten() => whereType<T>();
}
