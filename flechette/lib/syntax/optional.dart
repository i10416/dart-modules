extension Optional<T> on T? {
  /// map value using function f if value is not null.
  R? map<R>(R Function(T) f) {
    if (this == null) {
      return null;
    } else {
      return f(this!);
    }
  }

  /// returns true if value is not null.
  bool get isEmpty => this == null;

  /// returns value returned from ifEmpty thunk if value is null. otherwise,
  /// returns value gained from applying function f to this value.
  ///
  /// example
  ///
  /// ```dart
  ///
  /// int? a = 1;
  /// int? b = null;
  ///
  /// a.fold(()=>'none')((elm)=> 'got $elm' ); // => got elm
  /// b.fold(()=>'none')((elm) => 'got $elm' ); => none
  /// ```
  ///
  R Function(R Function(T)) fold<R>(R Function() ifEmpty) {
    if (this == null) {
      return (_) => ifEmpty();
    } else {
      return (f) => f(this!);
    }
  }

  /// returns if value is not empty and matches given function f.
  ///
  /// example
  ///
  /// ```dart
  /// int? a = 2;
  /// int? b = 3;
  /// int? c = null;
  /// a.filter((element) => element %2 == 0) // => 2
  /// b.filter((element) => element %2 == 0) // => null
  /// c.filter(...) // => null
  /// ```
  ///
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

  /// returns value if value is not null, else returns given els value.
  T getOrElse(T Function() els) {
    if (this == null) {
      return els();
    } else {
      return this!;
    }
  }

  /// do side-effect operation if this value is not empty
  void foreach(void Function(T) f) {
    if (this == null) {
      return;
    } else {
      f(this!);
    }
  }

  /// returns some value if both this and returned value of function f are some.
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

  /// convert optional value into list of length 0 or 1.
  List<T> toList() => this == null ? [] : [this!];
}
