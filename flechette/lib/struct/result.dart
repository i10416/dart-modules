class Result<T> {
  Result({
    required this.isSuccess,
    this.value,
    this.errorKey,
    this.errorMessage,
  });

  Result.success(T value) : this(isSuccess: true, value: value);

  Result.failure(String errorKey, String errorMessage)
      : this(isSuccess: false, errorKey: errorKey, errorMessage: errorMessage);

  final bool isSuccess;
  final T? value;

  Result<R> map<R>(R Function(T) f) {
    if (isSuccess) {
      return Result.success(f(value!));
    } else {
      return Result<R>(
        isSuccess: false,
        errorKey: errorKey,
        errorMessage: errorMessage,
      );
    }
  }

  T? get toOptional => value;

  Result<R> flatMap<R>(Result<R> Function(T) f) {
    if (isSuccess) {
      return f(value!);
    } else {
      return Result.failure(errorKey!, errorMessage!);
    }
  }

  final String? errorKey;
  final String? errorMessage;
}
