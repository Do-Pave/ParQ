class UserMethodsListModel {
  List<Data>? data;
  bool? success;

  UserMethodsListModel({this.data, this.success});

  UserMethodsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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