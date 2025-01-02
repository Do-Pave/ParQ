class CreateWalletModel {
  Data? data;
  bool? success;

  CreateWalletModel({this.data, this.success});

  CreateWalletModel.fromJson(Map<String, dynamic> json) {
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
  int? balance;
  String? currency;
  String? type;
  String? createdAt;

  Data({this.id, this.balance, this.currency, this.type, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
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