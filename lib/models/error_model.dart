class ErrorModel {
  int? statusCode;
  String? timestamp;
  dynamic response; // Can be String or List<String>
  String? path;
  String? error;
  String? errorDescription;

  ErrorModel({
    this.statusCode,
    this.timestamp,
    this.response,
    this.path,
    this.error,
    this.errorDescription,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    response = json['response'];
    path = json['path'];
    error = json['error'];
    errorDescription = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['timestamp'] = timestamp;
    data['response'] = response;
    data['path'] = path;
    data['error'] = error;
    data['error_description'] = errorDescription;
    return data;
  }

  // Helper to parse response field as a String or List<String>
  List<String> getResponseMessages() {
    if (response is String) {
      return [response as String];
    } else if (response is List) {
      return (response as List).map((e) => e.toString()).toList();
    } else {
      return [];
    }
  }
}



class ParqErrorModel {
  int? statusCode;
  List<String>? message;
  String? timestamp;
  String? path;

  ParqErrorModel({this.statusCode, this.message, this.timestamp, this.path});

  ParqErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'].cast<String>();
    timestamp = json['timestamp'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['path'] = this.path;
    return data;
  }

  List<String> getResponseMessages() {
    if (message is String) {
      return [message as String];
    } else if (message is List) {
      return (message as List).map((e) => e.toString()).toList();
    } else {
      return [];
    }
  }
}