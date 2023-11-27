// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mpc/data/models/academies_model.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/data/models/single_academiec_model.dart';
import 'package:mpc/data/models/single_event_model.dart';
import 'package:mpc/data/models/user_login_model.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier {
  final ApiService apiService;

  HomeViewModel({required this.apiService});
  LoginResponse? _savedLoginResponse;
  List<EventData> _todayPrograms = [];
  List<EventData> _onGoingPrograms = [];
  List<EventData> _upCominPrograms = [];
  List<EventData> _archivedPrograms = [];
  List<EventData> _byCategoryPrograms = [];
  List<EventData> _byAcademiecPrograms = [];
  List<CatrgoryModel> _catrgory = [];
  List<String> _imageUrls = [];
  List<DepartmentModel> _academies = [];
  SingleAacademies _singleAcademic = SingleAacademies();
  SingleProgram _singleProgram = SingleProgram();

  bool _isLoading = false;
  bool _isExpanded = false;
  String _about = "";
  String _version = "";

  List<EventData> get todayPrograms => _todayPrograms;
  List<EventData> get onGoingPrograms => _onGoingPrograms;
  List<EventData> get upConingPrograms => _upCominPrograms;
  List<EventData> get archivedPrograms => _archivedPrograms;
  List<EventData> get byCategoreyProgramList => _byCategoryPrograms;
  List<EventData> get byAcaedmiecProgramList => _byAcademiecPrograms;
  List<CatrgoryModel> get category => _catrgory;
  List<String> get imageUrls => _imageUrls;
  List<DepartmentModel> get academiesList => _academies;
  bool get isLoading => _isLoading;
  bool get isExpanded => _isExpanded;
  String get about => _about;
  String get version => _version;
  SingleAacademies get singleAacademies => _singleAcademic;
  SingleProgram get singleProgram => _singleProgram;
  LoginResponse? get userLoginData => _savedLoginResponse;

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

// check user
  void user() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedLoginResponseString = prefs.getString('loginResponse');
    if (savedLoginResponseString != null) {
      final Map<String, dynamic> savedLoginResponseMap =
          json.decode(savedLoginResponseString);
      _savedLoginResponse = LoginResponse.fromJson(savedLoginResponseMap);
      print(
          "if section print ${_savedLoginResponse!.isSuccess} user ${_savedLoginResponse!.currentUser!.id.toString()}");
    } else {
      _savedLoginResponse = LoginResponse(false, null);
      print("else section print ${_savedLoginResponse!.isSuccess}");
    }
  }

  // about data
  Future<void> fetchAboutUs(BuildContext context) async {
    if (about.isEmpty) {
      try {
        _isLoading = true;
        final about = await apiService.getAboutUsContent();
        _about = about;
      } catch (e) {
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching aboutUS: $e');
      } finally {}
      _isLoading = false;
      notifyListeners();
    }
  }

// today program
  Future<void> fetchTodayPrograms(BuildContext context) async {
    if (todayPrograms.isEmpty) {
      try {
        _isLoading = true;
        final programs =
            await apiService.getTodayPrograms("/Api/today_programs");
        _todayPrograms = programs;
      } catch (e) {
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching today\'s programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

// OnGoing program
  Future<void> fetchOnGoingPrograms(BuildContext context) async {
    if (onGoingPrograms.isEmpty) {
      try {
        _isLoading = true;
        final programs =
            await apiService.getTodayPrograms("/Api/ongoing_programme");
        _onGoingPrograms = programs;
      } catch (e) {
        // Handle error
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching OnGoing\'s programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

// UpComin program
  Future<void> fetchUpComingPrograms(BuildContext context) async {
    if (upConingPrograms.isEmpty) {
      try {
        _isLoading = true;
        final programs =
            await apiService.getTodayPrograms("/Api/upcoming_programme");
        _upCominPrograms = programs;
      } catch (e) {
        // Handle error
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching UpComing\'s programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

// Archived program
  Future<void> fetchArchivedPrograms(BuildContext context) async {
    if (archivedPrograms.isEmpty) {
      try {
        _isLoading = true;
        final programs =
            await apiService.getTodayPrograms("/Api/archived_programs");
        _archivedPrograms = programs;
      } catch (e) {
        // Handle error
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching Archived\'s programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // slider image function
  Future<void> fetchSliderImages(BuildContext context) async {
    if (imageUrls.isEmpty) {
      try {
        _isLoading = true;
        final programs = await apiService.getSliderImages();
        _imageUrls = programs;
      } catch (e) {
        _isLoading = false;
        // Handle error
        CustomSnackbar.show(context, 'Error fetching Slider images: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // Categorey fetching
  Future<void> fetchAllCategories(BuildContext context) async {
    if (category.isEmpty) {
      try {
        _isLoading = true;
        final programs = await apiService.getAllCategories();
        _catrgory = programs;
      } catch (e) {
        // Handle error
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching Categories: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // Acadmiec data
  Future<void> fetchAllAcadmiec(BuildContext context) async {
    if (academiesList.isEmpty) {
      try {
        _isLoading = true;
        final programs = await apiService.getAllAcadmiec();
        _academies = programs;
      } catch (e) {
        // Handle error
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching academies: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // Single Academiec data
  Future<void> fetchSingleAcademiec(BuildContext context, String id) async {
    try {
      _isLoading = true;
      _singleAcademic = SingleAacademies();
      final programs = await apiService.getSingleAcademice(id);
      _singleAcademic = programs;
      print("acadmin name ${_singleAcademic.deptName} ");
      _fetchAcademiecPrograms(context, _singleAcademic.deptName!);
    } catch (e) {
      // Handle error
      _isLoading = false;
      CustomSnackbar.show(context, 'Error fetching academies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Single Program data
  Future<void> fetchSingleProgram(BuildContext context, String id) async {
    try {
      _isLoading = true;
      final programs = await apiService.getSingleProgram(id);
      _singleProgram = programs;
    } catch (e) {
      // Handle error
      _isLoading = false;
      CustomSnackbar.show(context, 'Error fetching academies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // today program
  Future<void> fetchProgramsByCagegory(
      BuildContext context, String categoreyName) async {
    try {
      _isLoading = true;
      _byCategoryPrograms.clear();
      final programs = await apiService.getTodayPrograms(
          "/Api/programs_by_category?program_category=$categoreyName");
      _byCategoryPrograms = programs;
    } catch (e) {
      _isLoading = false;
      CustomSnackbar.show(context, 'Error fetching programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // today program
  Future<void> fetchProgramsByAcademiec(
      BuildContext context, String academiecName) async {
    if (todayPrograms.isEmpty) {
      try {
        _isLoading = true;
        final programs = await apiService.getTodayPrograms(
            "/Api/programs_by_academies?program_category=$academiecName");
        _byAcademiecPrograms = programs;
      } catch (e) {
        _isLoading = false;
        CustomSnackbar.show(context, 'Error fetching programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // academiec programes
  Future<void> _fetchAcademiecPrograms(
      BuildContext context, String depName) async {
    try {
      _byAcademiecPrograms = [];
      _isLoading = true;
      final programs = await apiService.getTodayPrograms(
          "/Api/programs_by_academies?program_academies=$depName");
      _byAcademiecPrograms = programs;
    } catch (e) {
      _isLoading = false;
      CustomSnackbar.show(context, 'Error fetching failed programs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
