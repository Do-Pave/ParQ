import 'package:parq/models/payment_category_methods_model.dart';

class MethodsModel {
  List<Methods>? data;
  bool? success;

  MethodsModel({this.data, this.success});

  MethodsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Methods>[];
      json['data'].forEach((v) {
        data!.add(new Methods.fromJson(v));
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
