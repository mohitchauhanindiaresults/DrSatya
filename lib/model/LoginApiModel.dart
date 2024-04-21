class LoginApiModel {
  final String? status;
  final String? message;
  final User? user;

  LoginApiModel({this.status, this.message, this.user});

  factory LoginApiModel.fromJson(Map<String, dynamic> json) {
    return LoginApiModel(
      status: json['status'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt; // It can be DateTime or null, based on your actual data
  final String? mobile;
  final String? designation;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final String? accessToken;
  final Roles? roles;
  final List<Designation>? designations;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.designation,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.roles,
    this.designations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      mobile: json['mobile'],
      designation: json['designation'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      accessToken: json['access_token'],
      roles: json['roles'] != null ? Roles.fromJson(json['roles']) : null,
      designations: json['designations'] != null
          ? (json['designations'] as List)
          .map((e) => Designation.fromJson(e))
          .toList()
          : null,
    );
  }
}

class Roles {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Roles({this.id, this.name, this.createdAt, this.updatedAt});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Designation {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final Pivot? pivot;

  Designation({this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}

class Pivot {
  final int? userId;
  final int? designationId;

  Pivot({this.userId, this.designationId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      designationId: json['designation_id'],
    );
  }
}
