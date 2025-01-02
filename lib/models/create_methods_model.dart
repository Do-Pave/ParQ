class CreateMethodsModel {
  Data? data;
  bool? success;

  CreateMethodsModel({this.data, this.success});

  CreateMethodsModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  bool? isFavorite;
  bool? enabled;
  String? userId;
  String? accountNumber;
  String? accountHolder;
  String? createdAt;
  String? updatedAt;
  String? lastUsedAt;
  String? payoutMethodId;
  PayoutMethod? payoutMethod;

  Data(
      {this.id,
        this.isFavorite,
        this.enabled,
        this.userId,
        this.accountNumber,
        this.accountHolder,
        this.createdAt,
        this.updatedAt,
        this.lastUsedAt,
        this.payoutMethodId,
        this.payoutMethod});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFavorite = json['isFavorite'];
    enabled = json['enabled'];
    userId = json['userId'];
    accountNumber = json['accountNumber'];
    accountHolder = json['accountHolder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastUsedAt = json['lastUsedAt'];
    payoutMethodId = json['payoutMethodId'];
    payoutMethod = json['payoutMethod'] != null
        ? new PayoutMethod.fromJson(json['payoutMethod'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFavorite'] = this.isFavorite;
    data['enabled'] = this.enabled;
    data['userId'] = this.userId;
    data['accountNumber'] = this.accountNumber;
    data['accountHolder'] = this.accountHolder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['lastUsedAt'] = this.lastUsedAt;
    data['payoutMethodId'] = this.payoutMethodId;
    if (this.payoutMethod != null) {
      data['payoutMethod'] = this.payoutMethod!.toJson();
    }
    return data;
  }
}

class PayoutMethod {
  String? id;
  bool? enabled;
  String? name;
  String? abbreviation;
  String? bic;
  List<int>? bicLength;
  String? notes;
  Null? logo;
  String? categoryId;

  PayoutMethod(
      {this.id,
        this.enabled,
        this.name,
        this.abbreviation,
        this.bic,
        this.bicLength,
        this.notes,
        this.logo,
        this.categoryId});

  PayoutMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enabled = json['enabled'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    bic = json['bic'];
    bicLength = json['bicLength'].cast<int>();
    notes = json['notes'];
    logo = json['logo'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enabled'] = this.enabled;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['bic'] = this.bic;
    data['bicLength'] = this.bicLength;
    data['notes'] = this.notes;
    data['logo'] = this.logo;
    data['categoryId'] = this.categoryId;
    return data;
  }
}







class CreateMethodErrorModel {
  int? statusCode;
  String? timestamp;
  Response? response;
  String? path;

  CreateMethodErrorModel(
      {this.statusCode, this.timestamp, this.response, this.path});

  CreateMethodErrorModel.fromJson(Map<String, dynamic> json) {
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