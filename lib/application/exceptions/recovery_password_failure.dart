class EmailNotFoundFailure implements Exception {
  final String? message;

  EmailNotFoundFailure({this.message});
}
