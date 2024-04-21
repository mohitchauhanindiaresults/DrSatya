class AssignRightsToRollModel {
  int status;
  String message;
  AssignRightsData data;
  AssignRightsError error;
  List<int> failedPacketIds;

  AssignRightsToRollModel({required this.status, required this.message, required this.data, required this.error, required this.failedPacketIds});

  factory AssignRightsToRollModel.fromJson(Map<String, dynamic> json) {
    return AssignRightsToRollModel(
      status: json['status'],
      message: json['message'],
      data: AssignRightsData.fromJson(json['data']),
      error: AssignRightsError.fromJson(json['error']),
      failedPacketIds: List<int>.from(json['failedPacketIds']),
    );
  }
}

class AssignRightsData {
  AssignRightsResultCode result;

  AssignRightsData({required this.result});

  factory AssignRightsData.fromJson(Map<String, dynamic> json) {
    return AssignRightsData(
      result: AssignRightsResultCode.fromJson(json['data']['ResultCode'][0]),
    );
  }
}

class AssignRightsResultCode {
  int resultCode;

  AssignRightsResultCode({required this.resultCode});

  factory AssignRightsResultCode.fromJson(Map<String, dynamic> json) {
    return AssignRightsResultCode(
      resultCode: json['ResultCode'],
    );
  }
}

class AssignRightsError {
  int code;
  String message;
  String details;

  AssignRightsError({required this.code, required this.message, required this.details});

  factory AssignRightsError.fromJson(Map<String, dynamic> json) {
    return AssignRightsError(
      code: json['code'],
      message: json['message'],
      details: json['details'],
    );
  }
}
