class MethodsAndCategModel {
  List<Data>? data;
  bool? success;

  MethodsAndCategModel({this.data, this.success});

  MethodsAndCategModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? logo;
  List<PayoutMethods>? payoutMethods;

  Data({this.id, this.name, this.logo, this.payoutMethods});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['PayoutMethods'] != null) {
      payoutMethods = <PayoutMethods>[];
      json['PayoutMethods'].forEach((v) {
        payoutMethods!.add(new PayoutMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    if (this.payoutMethods != null) {
      data['PayoutMethods'] =
          this.payoutMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayoutMethods {
  String? id;
  bool? enabled;
  String? name;
  String? abbreviation;
  String? bic;
  List<int>? bicLength;
  String? notes;
  Null? logo;
  String? categoryId;

  PayoutMethods(
      {this.id,
        this.enabled,
        this.name,
        this.abbreviation,
        this.bic,
        this.bicLength,
        this.notes,
        this.logo,
        this.categoryId});

  PayoutMethods.fromJson(Map<String, dynamic> json) {
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