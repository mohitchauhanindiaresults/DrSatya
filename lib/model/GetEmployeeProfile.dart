class GetEmployeeProfile {
  int status;
  String message;
  EmployeeProfileData data;
  EmployeeProfileError error;
  List<dynamic> failedPacketIds;

  GetEmployeeProfile({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
    required this.failedPacketIds,
  });

  factory GetEmployeeProfile.fromJson(Map<String, dynamic> json) {
    return GetEmployeeProfile(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: EmployeeProfileData.fromJson(json['data'] ?? {}),
      error: EmployeeProfileError.fromJson(json['error'] ?? {}),
      failedPacketIds: json['failedPacketIds'] ?? [],
    );
  }
}

class EmployeeProfileData {
  EmployeeProfileInnerData data;

  EmployeeProfileData({
    required this.data,
  });

  factory EmployeeProfileData.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileData(
      data: EmployeeProfileInnerData.fromJson(json['data'] ?? {}),
    );
  }
}

class EmployeeProfileInnerData {
  List<EmployeeProfile> employeeProfiles;
  List<ResultCode> resultCode;

  EmployeeProfileInnerData({
    required this.employeeProfiles,
    required this.resultCode,
  });

  factory EmployeeProfileInnerData.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileInnerData(
      employeeProfiles: (json['EmployeeProfile'] as List<dynamic> ?? [])
          .map((profile) => EmployeeProfile.fromJson(profile))
          .toList(),
      resultCode: (json['ResultCode'] as List<dynamic> ?? [])
          .map((code) => ResultCode.fromJson(code))
          .toList(),
    );
  }
}

class EmployeeProfile {
  int employeeId;
  String name;
  String roll;
  String email;
  String mobile;
  String qualification;
  String address;
  String experience;
  String password;
  String createdDate;
  String lastModifyDate;
  int active;
  String session;

  EmployeeProfile({
    required this.employeeId,
    required this.name,
    required this.roll,
    required this.email,
    required this.mobile,
    required this.qualification,
    required this.address,
    required this.experience,
    required this.password,
    required this.createdDate,
    required this.lastModifyDate,
    required this.active,
    required this.session,
  });

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      employeeId: json['EmployeeId'] ?? 0,
      name: json['Name'] ?? '',
      roll: json['Roll'] ?? '',
      email: json['Email'] ?? '',
      mobile: json['Mobile'] ?? '',
      qualification: json['Qulification'] ?? '',
      address: json['Address'] ?? '',
      experience: json['Experience'] ?? '',
      password: json['Password'] ?? '',
      createdDate: json['createdDate'] ?? '',
      lastModifyDate: json['LastModifyDate'] ?? '',
      active: json['Active'] ?? 0,
      session: json['Session'] ?? '',
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

class EmployeeProfileError {
  int code;
  String message;
  String details;

  EmployeeProfileError({
    required this.code,
    required this.message,
    required this.details,
  });

  factory EmployeeProfileError.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileError(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      details: json['details'] ?? '',
    );
  }
}
