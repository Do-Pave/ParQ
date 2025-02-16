class AllParkingModel {
  List<AllParking>? data;
  bool? success;

  AllParkingModel({this.data, this.success});

  AllParkingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllParking>[];
      json['data'].forEach((v) {
        data!.add(new AllParking.fromJson(v));
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

class AllParking {
  String? sId;
  Brand? brand;
  String? parkingName;
  Location? location;
  String? logo;
  String? description;
  List<String>? images;
  String? parkingType;
  List<Services>? services;
  int? netPrice;
  List<Spots>? spots;
  List<Reviews>? reviews;

  AllParking(
      {this.sId,
        this.brand,
        this.parkingName,
        this.location,
        this.logo,
        this.description,
        this.images,
        this.parkingType,
        this.services,
        this.netPrice,
        this.spots,
        this.reviews
      });

  AllParking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    parkingName = json['parkingName'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['parkingName'] = this.parkingName;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
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
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
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

class Location {
  String? type;
  String? address;
  List<double>? coordinates;
  double? latitude;
  double? longitude;

  Location({this.type, this.coordinates, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
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

class Reviews {
  String? note;
  String? userId;
  double? rate;

  Reviews({this.note, this.userId, this.rate});

  Reviews.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    userId = json['userId'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['userId'] = this.userId;
    data['rate'] = this.rate;
    return data;
  }
}