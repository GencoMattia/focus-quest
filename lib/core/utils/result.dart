/// A type that represents either a success or a failure.
/// 
/// This is useful for operations that can fail and need to return
/// detailed error information without throwing exceptions.
/// 
/// Example:
/// ```dart
/// Result<User, String> result = await userRepository.getUser(id);
/// result.when(
///   success: (user) => print('Got user: ${user.name}'),
///   failure: (error) => print('Error: $error'),
/// );
/// ```
sealed class Result<T, E> {
  const Result();

  /// Creates a successful result
  const factory Result.success(T value) = Success<T, E>;

  /// Creates a failed result
  const factory Result.failure(E error) = Failure<T, E>;

  /// Returns true if this is a success
  bool get isSuccess => this is Success<T, E>;

  /// Returns true if this is a failure
  bool get isFailure => this is Failure<T, E>;

  /// Gets the value if successful, otherwise returns null
  T? get valueOrNull => switch (this) {
    Success(value: final v) => v,
    Failure() => null,
  };

  /// Gets the error if failed, otherwise returns null
  E? get errorOrNull => switch (this) {
    Success() => null,
    Failure(error: final e) => e,
  };

  /// Pattern matching on the result
  R when<R>({
    required R Function(T value) success,
    required R Function(E error) failure,
  }) {
    return switch (this) {
      Success(value: final v) => success(v),
      Failure(error: final e) => failure(e),
    };
  }

  /// Maps the success value to a new type
  Result<R, E> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success(value: final v) => Result.success(transform(v)),
      Failure(error: final e) => Result.failure(e),
    };
  }

  /// Maps the error value to a new type
  Result<T, R> mapError<R>(R Function(E error) transform) {
    return switch (this) {
      Success(value: final v) => Result.success(v),
      Failure(error: final e) => Result.failure(transform(e)),
    };
  }
}

/// Represents a successful result
final class Success<T, E> extends Result<T, E> {
  final T value;

  const Success(this.value);

  @override
  String toString() => 'Success($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T, E> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a failed result
final class Failure<T, E> extends Result<T, E> {
  final E error;

  const Failure(this.error);

  @override
  String toString() => 'Failure($error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T, E> && error == other.error;

  @override
  int get hashCode => error.hashCode;
}
