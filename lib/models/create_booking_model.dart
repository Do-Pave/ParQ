class CreateBookingModel {
  Data? data;
  bool? success;

  CreateBookingModel({this.data, this.success});

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  Booking? booking;
  Parking? parking;
  UserInfo? userInfo;
  String? qrCode;
  bool? enable;

  Data(
      {this.sId,
        this.booking,
        this.parking,
        this.userInfo,
        this.qrCode,
        this.enable});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    parking =
    json['parking'] != null ? new Parking.fromJson(json['parking']) : null;
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    qrCode = json['qrCode'];
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.parking != null) {
      data['parking'] = this.parking!.toJson();
    }
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    data['qrCode'] = this.qrCode;
    data['enable'] = this.enable;
    return data;
  }
}

class Booking {
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
  int? iV;

  Booking(
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
        this.paidReservation,
        this.iV});

  Booking.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
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
    data['__v'] = this.iV;
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

class Parking {
  Location? location;
  String? sId;
  Brand? brand;
  String? brandName;
  String? parkingName;
  String? logo;
  String? description;
  List<String>? images;
  String? parkingType;
  List<Services>? services;
  int? netPrice;
  List<Spots>? spots;
  List<String>? reviews;
  int? iV;

  Parking(
      {this.location,
        this.sId,
        this.brand,
        this.brandName,
        this.parkingName,
        this.logo,
        this.description,
        this.images,
        this.parkingType,
        this.services,
        this.netPrice,
        this.spots,
        this.reviews,
        this.iV});

  Parking.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    brandName = json['brandName'];
    parkingName = json['parkingName'];
    logo = json['logo'];
    description = json['description'];
    images = json['images'].cast<String>();
    parkingType = json['parkingType'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    netPrice = json['netPrice'];
    if (json['spots'] != null) {
      spots = <Spots>[];
      json['spots'].forEach((v) {
        spots!.add(new Spots.fromJson(v));
      });
    }

    // reviews need to handled, after back end return it nullable
    // if (json['reviews'] != null) {
    //   reviews = <String>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['brandName'] = this.brandName;
    data['parkingName'] = this.parkingName;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['images'] = this.images;
    data['parkingType'] = this.parkingType;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['netPrice'] = this.netPrice;
    if (this.spots != null) {
      data['spots'] = this.spots!.map((v) => v.toJson()).toList();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  List<double>? coordinates;
  String? address;
  String? type;

  Location({this.coordinates, this.address, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}

class Brand {
  String? sId;
  String? brandName;
  String? owner;
  String? phone;
  String? logo;
  int? iV;

  Brand({this.sId, this.brandName, this.owner, this.phone, this.logo, this.iV});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brandName'];
    owner = json['owner'];
    phone = json['phone'];
    logo = json['logo'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brandName'] = this.brandName;
    data['owner'] = this.owner;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['__v'] = this.iV;
    return data;
  }
}

class Services {
  String? name;
  int? price;

  Services({this.name, this.price});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class Spots {
  String? name;
  bool? available;

  Spots({this.name, this.available});

  Spots.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['available'] = this.available;
    return data;
  }
}