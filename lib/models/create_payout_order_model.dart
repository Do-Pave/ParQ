class CreatePayoutOrderModel {
  Data? data;
  bool? success;

  CreatePayoutOrderModel({this.data, this.success});

  CreatePayoutOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? uuid;
  String? walletId;
  String? status;
  String? type;
  int? amount;
  String? currency;
  String? successRedirectUrl;
  String? failRedirectUrl;

  Data(
      {this.id,
      this.uuid,
      this.walletId,
      this.status,
      this.type,
      this.amount,
      this.currency,
      this.successRedirectUrl,
      this.failRedirectUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    walletId = json['walletId'];
    status = json['status'];
    type = json['type'];
    amount = json['amount'];
    currency = json['currency'];
    successRedirectUrl = json['success_redirect_url'];
    failRedirectUrl = json['fail_redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['walletId'] = this.walletId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['success_redirect_url'] = this.successRedirectUrl;
    data['fail_redirect_url'] = this.failRedirectUrl;
    return data;
  }
}




class CreatePayoutOrderErrorModel {
  int? statusCode;
  String? timestamp;
  Response? response;
  String? path;

  CreatePayoutOrderErrorModel(
      {this.statusCode, this.timestamp, this.response, this.path});

  CreatePayoutOrderErrorModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? message;
  String? error;
  int? statusCode;

  Response({this.message, this.error, this.statusCode});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    return data;
  }
}