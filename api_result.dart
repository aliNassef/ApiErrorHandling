class ApiResult<T> {
  final T? data;
  final String? errMessage;

  const ApiResult._({this.data, this.errMessage});

  factory ApiResult.onSuccess(T data) {
    return ApiResult._(data: data);
  }

  factory ApiResult.onFailure(String errMessage) {
    return ApiResult._(errMessage: errMessage);
  }

  bool get isSuccess => errMessage == null;

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    return isSuccess
        ? success(data as T)
        : failure(errMessage!);
  }
}
