class LoginSignupResp {
  Success? success;

  LoginSignupResp({this.success});

  LoginSignupResp.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  String? appleToken;
  String? gmailToken;
  String? random;
  String? createdAt;
  String? updatedAt;

  Success(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.appleToken,
      this.gmailToken,
      this.random,
      this.createdAt,
      this.updatedAt});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    appleToken = json['apple_token'];
    gmailToken = json['gmail_token'];
    random = json['random'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['apple_token'] = this.appleToken;
    data['gmail_token'] = this.gmailToken;
    data['random'] = this.random;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
