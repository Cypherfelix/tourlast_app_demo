/// Base exception for data layer errors.
abstract class DataException implements Exception {
  const DataException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => message;
}

/// Exception thrown when data is not found.
class DataNotFoundException extends DataException {
  const DataNotFoundException(super.message, [super.stackTrace]);
}

/// Exception thrown when data parsing fails.
class DataParsingException extends DataException {
  const DataParsingException(super.message, [super.stackTrace]);
}

/// Exception thrown when data source fails.
class DataSourceException extends DataException {
  const DataSourceException(super.message, [super.stackTrace]);
}
