import '../Api/endpoints.dart';

class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage,/*this.status*/});
  factory ErrorModel.fromJson(dynamic jsonData) {
  return ErrorModel(
    errorMessage: jsonData[ApiKey.error][ApiKey.message],
  );
}

}
