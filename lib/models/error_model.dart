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
