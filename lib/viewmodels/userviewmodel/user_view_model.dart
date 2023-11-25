// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:mpc/widgets/custom_snackbar.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService apiService;

  UserViewModel({required this.apiService});

  bool _isLoading = false;
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;
  bool get isLoading => _isLoading;

  // User profile data
  Future<void> fetchUserProfil(BuildContext context, int id) async {
    if (!(_userModel.id != null)) {
      try {
        _isLoading = true;
        final programs = await apiService.getUserProfile(id);
        _userModel = programs;
      } catch (e) {
        CustomSnackbar.show(context, 'Error fetching User Profile: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
