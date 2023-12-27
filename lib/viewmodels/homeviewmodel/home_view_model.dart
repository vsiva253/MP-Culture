// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mpc/data/models/academies_model.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/data/models/single_academiec_model.dart';
import 'package:mpc/data/models/single_event_model.dart';
import 'package:mpc/data/services/api_service.dart';

class HomeViewModel with ChangeNotifier {
  final ApiService apiService;

  HomeViewModel({required this.apiService});

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

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  Map<DateTime, List<EventData>> forTableEventsList = {};
  void _convertEventsToMap(List<EventData> events) {
    forTableEventsList = {};
    for (EventData event in events) {
      DateTime startDate = DateTime.parse(event.startingDate ?? '');
      if (forTableEventsList.containsKey(startDate)) {
        forTableEventsList[startDate]!.add(event);
      } else {
        forTableEventsList[startDate] = [event];
      }
    }
    print(forTableEventsList);
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
    if (about.isEmpty) {
      try {
        _isLoading = true;
        final about = await apiService.getAboutUsContent();
        _about = about;
      } catch (e) {
        _isLoading = false;
        // // CustomSnackbar.show(context, 'Error fetching aboutUS');
        throw ("Error fetching aboutUS: $e");
      } finally {}
      Future.delayed(const Duration(seconds: 1), () {
        _isLoading = false;
      });

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
        // // CustomSnackbar.show(context, 'Error fetching today\'s programs');
        throw ("Error fetching today\'s programs: $e");
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
        // // CustomSnackbar.show(context, 'Error fetching OnGoing\'s programs');
        throw ('Error fetching OnGoing\'s programs: $e');
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
        // // CustomSnackbar.show(context, 'Error fetching UpComing\'s programs');
        throw ('Error fetching OnGoing\'s programs: $e');
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
        // CustomSnackbar.show(context, 'Error fetching Archived\'s programs');
        throw ('Error fetching Archived\'s programs: $e');
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
        // CustomSnackbar.show(context, 'Error fetching Slider images');
        throw ('Error fetching Slider images: $e');
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
        // CustomSnackbar.show(context, 'Error fetching Categories');
        throw ('Error fetching Categories: $e');
      } finally {
        Future.delayed(const Duration(seconds: 1), () {
          _isLoading = false;
        });

        notifyListeners();
      }
    }
  }

  bool loadList = false;

  // Acadmiec data
  Future<void> fetchAllAcadmiec(BuildContext context) async {
    if (academiesList.isEmpty) {
      try {
        _isLoading = true;
        final programs = await apiService.getAllAcadmiec();
        _academies = programs;
        loadList = true;
      } catch (e) {
        // Handle error
        _isLoading = false;
        // CustomSnackbar.show(context, 'Error fetching academies');
        throw ('Error fetching academies: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // Single Academiec data
  // Future<void> fetchSingleAcademiec(BuildContext context, String id) async {
  //   _fetchAcademiecPrograms(context, id);
  //   print("single acadmic program faching ");
  //   try {
  //     _isLoading = true;
  //     _singleAcademic = SingleAacademies();
  //     final programs = await apiService.getSingleAcademice(id);
  //     _singleAcademic = programs;
  //     _fetchAcademiecPrograms(context, _singleAcademic.deptName!);
  //     throw ("acadmin name ${_singleAcademic.deptName} ");
  //   } catch (e) {
  //     // Handle error
  //     _isLoading = false;
  //     // CustomSnackbar.show(context, 'Error fetching academies: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Single Program data
  Future<void> fetchSingleProgram(BuildContext context, String id) async {
    try {
      _isLoading = true;
      final programs = await apiService.getSingleProgram(id);
      _singleProgram = programs;
    } catch (e) {
      // Handle error
      _isLoading = false;
      // CustomSnackbar.show(context, 'Error fetching academies');
      throw ('Error fetching academies: $e');
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
      // CustomSnackbar.show(context, 'Error fetching programs');
      throw ('Error fetching programs: $e');
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
        // CustomSnackbar.show(context, 'Error fetching programs');
        throw ('Error fetching programs: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  bool isProgramoading = false;

  // academiec programes
  Future<void> fetchAcademiecPrograms(
      BuildContext context, String depName) async {
    try {
      _byAcademiecPrograms = [];
      // _isLoading = true;
      isProgramoading = true;
      final programs = await apiService.getTodayPrograms(
          "/Api/programs_by_academies?program_academies=$depName");

      _byAcademiecPrograms = programs;
      _convertEventsToMap(programs);
    } catch (e) {
      // _isLoading = false;
      isProgramoading = false;
      // CustomSnackbar.show(context, 'Error fetching failed programs: $e');
    } finally {
      // _isLoading = false;
      isProgramoading = false;
      notifyListeners();
    }
  }
}
