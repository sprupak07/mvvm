import 'package:mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  String? message;
  T? data;

  ApiResponse({this.status, this.message, this.data});

  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'status: \n $status,\n message: $message, \n data: $data';
  }
}
