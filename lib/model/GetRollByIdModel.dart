class GetRollByIdModel {
  int status;
  String message;
  Data data;
  Error error;
  List<dynamic> failedPacketIds;

  GetRollByIdModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
    required this.failedPacketIds,
  });

  factory GetRollByIdModel.fromJson(Map<String, dynamic> json) {
    return GetRollByIdModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: Data.fromJson(json['data'] ?? {}),
      error: Error.fromJson(json['error'] ?? {}),
      failedPacketIds: List<dynamic>.from(json['failedPacketIds'] ?? []),
    );
  }
}

class Data {
  DataDetails data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: DataDetails.fromJson(json['data'] ?? {}),
    );
  }
}

class DataDetails {
  List<Roll> rolls;
  List<ResultCode> resultCode;

  DataDetails({
    required this.rolls,
    required this.resultCode,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    return DataDetails(
      rolls: List<Roll>.from(json['Roll']?.map((x) => Roll.fromJson(x)) ?? []),
      resultCode: List<ResultCode>.from(json['ResultCode']?.map((x) => ResultCode.fromJson(x)) ?? []),
    );
  }
}

class Roll {
  int id;
  String rollName;
  String rollWorkRight;

  Roll({
    required this.id,
    required this.rollName,
    required this.rollWorkRight,
  });

  factory Roll.fromJson(Map<String, dynamic> json) {
    return Roll(
      id: json['Id'] ?? 0,
      rollName: json['RollName'] ?? "",
      rollWorkRight: json['RollWorkRight'] ?? "",
    );
  }
}

class ResultCode {
  int resultCode;

  ResultCode({
    required this.resultCode,
  });

  factory ResultCode.fromJson(Map<String, dynamic> json) {
    return ResultCode(
      resultCode: json['ResultCode'] ?? 0,
    );
  }
}

class Error {
  int code;
  String message;
  String details;

  Error({
    required this.code,
    required this.message,
    required this.details,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json['code'] ?? 0,
      message: json['message'] ?? "",
      details: json['details'] ?? "",
    );
  }
}
