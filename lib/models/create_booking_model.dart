class CreateBookingModel {
  Data? createBookingData;
  bool? success;

  CreateBookingModel({this.createBookingData, this.success});

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
    createBookingData = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createBookingData != null) {
      data['data'] = this.createBookingData!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? sId;
  String? bookingType;
  String? date;
  String? arrivingTime;
  String? exitTime;
  int? totalHours;
  String? userId;
  UserInfo? userInfo;
  String? parking;
  List<String>? services;
  String? parkingSpot;
  String? vehicleType;
  int? fees;
  int? totalPrice;
  PaymentChannel? paymentChannel;
  bool? paidReservation;

  Data(
      {this.sId,
        this.bookingType,
        this.date,
        this.arrivingTime,
        this.exitTime,
        this.totalHours,
        this.userId,
        this.userInfo,
        this.parking,
        this.services,
        this.parkingSpot,
        this.vehicleType,
        this.fees,
        this.totalPrice,
        this.paymentChannel,
        this.paidReservation});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookingType = json['bookingType'];
    date = json['date'];
    arrivingTime = json['arrivingTime'];
    exitTime = json['exitTime'];
    totalHours = json['totalHours'];
    userId = json['userId'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    parking = json['parking'];
    services = json['services'].cast<String>();
    parkingSpot = json['parkingSpot'];
    vehicleType = json['vehicleType'];
    fees = json['fees'];
    totalPrice = json['totalPrice'];
    paymentChannel = json['paymentChannel'] != null
        ? new PaymentChannel.fromJson(json['paymentChannel'])
        : null;
    paidReservation = json['paidReservation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bookingType'] = this.bookingType;
    data['date'] = this.date;
    data['arrivingTime'] = this.arrivingTime;
    data['exitTime'] = this.exitTime;
    data['totalHours'] = this.totalHours;
    data['userId'] = this.userId;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    data['parking'] = this.parking;
    data['services'] = this.services;
    data['parkingSpot'] = this.parkingSpot;
    data['vehicleType'] = this.vehicleType;
    data['fees'] = this.fees;
    data['totalPrice'] = this.totalPrice;
    if (this.paymentChannel != null) {
      data['paymentChannel'] = this.paymentChannel!.toJson();
    }
    data['paidReservation'] = this.paidReservation;
    return data;
  }
}

class UserInfo {
  int? sub;
  String? phone;
  String? fullName;
  int? iat;
  int? exp;

  UserInfo({this.sub, this.phone, this.fullName, this.iat, this.exp});

  UserInfo.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    phone = json['phone'];
    fullName = json['fullName'];
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    data['iat'] = this.iat;
    data['exp'] = this.exp;
    return data;
  }
}

class PaymentChannel {
  String? status;

  PaymentChannel({this.status});

  PaymentChannel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}