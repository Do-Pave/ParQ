class MyTransactionsModel {
  Data? data;
  bool? success;

  MyTransactionsModel({this.data, this.success});

  MyTransactionsModel.fromJson(Map<String, dynamic> json) {
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
  List<Transactions>? transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  int? amount;
  String? status;
  String? currency;
  Null? note;
  String? direction;
  String? createdAt;

  Transactions({this.id,
    this.amount,
    this.status,
    this.currency,
    this.note,
    this.direction,
    this.createdAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    currency = json['currency'];
    note = json['note'];
    direction = json['direction'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['note'] = this.note;
    data['direction'] = this.direction;
    data['createdAt'] = this.createdAt;
    return data;
  }
}


class MyTransactionsErrorModel {
  int? statusCode;
  String? timestamp;
  Response? response;
  String? path;

  MyTransactionsErrorModel(
      {this.statusCode, this.timestamp, this.response, this.path});

  MyTransactionsErrorModel.fromJson(Map<String, dynamic> json) {
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
