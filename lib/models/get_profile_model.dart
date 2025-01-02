class GetProfileModel {
  Data? data;
  bool? success;

  GetProfileModel({this.data, this.success});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  Details? details;

  Data({this.details});

  Data.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  String? email;
  bool? emailVerified;
  bool? enabled;
  String? firstName;
  String? lastName;
  String? username;

  Details(
      {this.email,
        this.emailVerified,
        this.enabled,
        this.firstName,
        this.lastName,
        this.username});

  Details.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailVerified = json['emailVerified'];
    enabled = json['enabled'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['enabled'] = this.enabled;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    return data;
  }
}


class GetProfileErrorModel {
  int? statusCode;
  String? timestamp;
  Response? response;
  String? path;

  GetProfileErrorModel(
      {this.statusCode, this.timestamp, this.response, this.path});

  GetProfileErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['path'] = this.path;
    return data;
  }
}

class Response {
  String? message;
  int? statusCode;

  Response({this.message, this.statusCode});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}