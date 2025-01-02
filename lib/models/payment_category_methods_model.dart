class PaymentCategoryMethodsModel {
  List<PaymentCategoryData>? data;
  bool? success;

  PaymentCategoryMethodsModel({this.data, this.success});

  PaymentCategoryMethodsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentCategoryData.fromJson(v));
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

class PaymentCategoryData {
  String? id;
  String? name;
  String? logo;
  List<Methods> methods = [];

  PaymentCategoryData({this.id, this.name, this.logo, required this.methods});

  PaymentCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['methods'] != null) {
      methods = <Methods>[];
      json['methods'].forEach((v) {
        methods.add(new Methods.fromJson(v));
      });
    }else{
      methods = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['methods'] = this.methods.map((v) => v.toJson()).toList();
    return data;
  }
}

class Methods {
  String? id;
  bool? enabled;
  String? name;
  String? abbreviation;
  String? bic;
  List<int>? bicLength = [];
  String? notes;
  String? logo;
  String? categoryId;

  Methods(
      {this.id,
        this.enabled,
        this.name,
        this.abbreviation,
        this.bic,
        required this.bicLength,
        this.notes,
        this.logo,
        this.categoryId});

  Methods.fromJson(Map<String, dynamic> json) {
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