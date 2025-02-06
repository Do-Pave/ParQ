class RegisterModel {
  Data? data;
  bool? success;

  RegisterModel({this.data, this.success});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? phone;
  String? otp;
  String? expiresAt;

  Data({this.phone, this.otp, this.expiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['otp'] = this.otp;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}
