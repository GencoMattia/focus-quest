/// Base exception class for all application-specific exceptions.
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() {
    final codeStr = code != null ? '[$code] ' : '';
    return 'AppException: $codeStr$message';
  }
}

/// Exception thrown when a network operation fails.
class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'NetworkException: ${super.toString()}';
}

/// Exception thrown when authentication fails.
class AuthException extends AppException {
  const AuthException(
    super.message, {
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'AuthException: ${super.toString()}';
}

/// Exception thrown when a database operation fails.
class DatabaseException extends AppException {
  const DatabaseException(
    super.message, {
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'DatabaseException: ${super.toString()}';
}

/// Exception thrown when data synchronization fails.
class SyncException extends AppException {
  const SyncException(
    super.message, {
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'SyncException: ${super.toString()}';
}

/// Exception thrown when validation fails.
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException(
    super.message, {
    super.code,
    this.fieldErrors,
    super.originalError,
  });

  @override
  String toString() {
    final fieldsStr = fieldErrors != null ? ' Fields: ${fieldErrors!.keys.join(', ')}' : '';
    return 'ValidationException: ${super.toString()}$fieldsStr';
  }
}

/// Exception thrown when a resource is not found.
class NotFoundException extends AppException {
  const NotFoundException(
    super.message, {
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'NotFoundException: ${super.toString()}';
}
