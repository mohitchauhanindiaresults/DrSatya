class AddMember {
  String? status;
  String? message;
  User? user;

  AddMember({this.status, this.message, this.user});

  factory AddMember.fromJson(Map<String, dynamic> json) {
    return AddMember(
      status: json['status'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  String? name;
  String? email;
  String? mobile;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? accessToken;
  User({
    this.name,
    this.email,
    this.mobile,
    this.role,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],

      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
      accessToken: json['access_token'],
    );
  }
}

class Designation {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Designation({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
