// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:mpc/widgets/custom_snackbar.dart';

class HomeViewModel with ChangeNotifier {
  final ApiService apiService;

  HomeViewModel({required this.apiService});

  List<EventData> _todayPrograms = [];
  List<EventData> _onGoingPrograms = [];
  List<EventData> _upCominPrograms = [];
  List<EventData> _archivedPrograms = [];

  bool _isLoading = false;
  bool _isExpanded = false;
  String _about = "";
  String _version = "";

  List<EventData> get todayPrograms => _todayPrograms;
  List<EventData> get onGoingPrograms => _onGoingPrograms;
  List<EventData> get upConingPrograms => _upCominPrograms;
  List<EventData> get archivedPrograms => _archivedPrograms;
  bool get isLoading => _isLoading;
  bool get isExpanded => _isExpanded;
  String get about => _about;
  String get version => _version;

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  void showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // about data
  Future<void> fetchAboutUs(BuildContext context) async {
    try {
      _isLoading = true;
      final about = await apiService.getAboutUsContent();
      _about = about;
    } catch (e) {
      CustomSnackbar.show(context, 'Error fetching aboutUS: $e');
    } finally {}
    _isLoading = false;
    notifyListeners();
  }

// today program
  Future<void> fetchTodayPrograms(BuildContext context) async {
    try {
      _isLoading = true;
      final programs = await apiService.getTodayPrograms("/Api/today_programs");
      _todayPrograms = programs;
    } catch (e) {
      CustomSnackbar.show(context, 'Error fetching today\'s programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// OnGoing program
  Future<void> fetchOnGoingPrograms(BuildContext context) async {
    try {
      _isLoading = true;
      final programs =
          await apiService.getTodayPrograms("/Api/ongoing_programme");
      _onGoingPrograms = programs;
    } catch (e) {
      // Handle error
      CustomSnackbar.show(context, 'Error fetching OnGoing\'s programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// UpComin program
  Future<void> fetchUpComingPrograms(BuildContext context) async {
    try {
      _isLoading = true;
      final programs =
          await apiService.getTodayPrograms("/Api/upcoming_programme");
      _upCominPrograms = programs;
    } catch (e) {
      // Handle error
      CustomSnackbar.show(context, 'Error fetching UpComing\'s programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// Archived program
  Future<void> fetchArchivedPrograms(BuildContext context) async {
    try {
      _isLoading = true;
      final programs =
          await apiService.getTodayPrograms("/Api/archived_programs");
      _archivedPrograms = programs;
    } catch (e) {
      // Handle error
      CustomSnackbar.show(context, 'Error fetching Archived\'s programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // checking version
}
