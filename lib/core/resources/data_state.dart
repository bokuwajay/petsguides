import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? dioException;
  final Exception? genericException;

  const DataState({this.data, this.dioException, this.genericException});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DioDataFailed<T> extends DataState<T> {
  const DioDataFailed(DioException dioException)
      : super(dioException: dioException);
}

class GenericDataFailed<T> extends DataState<T> {
  const GenericDataFailed(Exception genericException)
      : super(genericException: genericException);
}
