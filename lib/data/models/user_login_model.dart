import 'package:mpc/data/models/user_model.dart';

class LoginResponse {
  final bool isSuccess;
  final UserModel? currentUser;

  LoginResponse(this.isSuccess, this.currentUser);

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'currentUser': currentUser?.toJson(),
    };
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['isSuccess'] as bool,
      json['currentUser'] != null
          ? UserModel.fromJson(json['currentUser'])
          : null,
    );
  }
}
