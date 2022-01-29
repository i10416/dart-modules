extension Optional<T> on T? {
  R? map<R>(R Function(T) f) {
    if (this == null) {
      return null;
    } else {
      return f(this!);
    }
  }

  T? filter(bool Function(T) f) {
    if (this == null) {
      return null;
    } else {
      if (f(this!)) {
        return this!;
      } else {
        return null;
      }
    }
  }

  T getOrElse(T Function() els) {
    if (this == null) {
      return els();
    } else {
      return this!;
    }
  }

  void foreach(void Function(T) f) {
    if (this == null) {
      return;
    } else {
      f(this!);
    }
  }

  R? flatMap<R>(R Function(T) f) {
    if (this == null) {
      return null;
    }
    return f(this!);
  }

  R mapOr<R>(R Function(T) f, {required R or}) {
    if (this == null) {
      return or;
    } else {
      return f(this!);
    }
  }
}
