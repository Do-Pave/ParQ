class MyWalletsModel {
  Data? data;
  bool? success;

  MyWalletsModel({this.data, this.success});

  MyWalletsModel.fromJson(Map<String, dynamic> json) {
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
  List<Wallets>? wallets;

  Data({this.wallets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallets {
  String? id;
  int? balance;
  String? currency;
  String? type;
  String? createdAt;

  Wallets({this.id, this.balance, this.currency, this.type, this.createdAt});

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    currency = json['currency'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    return data;
  }
}


class MyWalletsErrorModel {
  int? statusCode;
  String? timestamp;
  Response? response;
  String? path;

  MyWalletsErrorModel(
      {this.statusCode, this.timestamp, this.response, this.path});

  MyWalletsErrorModel.fromJson(Map<String, dynamic> json) {
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