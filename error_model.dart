class ErrorModel {
  final String message;
  const ErrorModel({required this.message});
  factory ErrorModel.fromJson(Map jsonData) {
    return ErrorModel(
      errorMessage: jsonData["message"] ?? 'Unknown error',
    );
  }
}
