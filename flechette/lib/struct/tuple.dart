class $<T, S> {
  const $(this.$0, this.$1);
  final T $0;
  final S $1;

  @override
  bool operator ==(Object other) =>
      other is $ && $0 == other.$0 && $1 == other.$1;

  @override
  int get hashCode => $0.hashCode ^ $1.hashCode;
}
