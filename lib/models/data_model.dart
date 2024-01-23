class AuthModel {
  final String message;
  final int connectionStatus;

  AuthModel({required this.message, required this.connectionStatus});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'],
      connectionStatus: json['connectionStatus'],
    );
  }
}
