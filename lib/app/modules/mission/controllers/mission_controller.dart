import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';

class MissionController extends GetxController {
  final RxList<Mission> missions = <Mission>[].obs;
  final RxString filter = "all".obs;

  @override
  void onInit() {
    super.onInit();
    _loadMissions();
  }

  void _loadMissions() {
    missions.addAll([
      Mission(
        id: "1",
        title: "Product Feedback Survey",
        description: "Answer 5 questions about your experience",
        questions: 5,
        points: 50,
        duration: "5 min",
        status: "available",
      ),
      Mission(
        id: "2",
        title: "App Usage Poll",
        description: "Tell us how you use reward apps",
        questions: 3,
        points: 30,
        duration: "2 min",
        status: "available",
      ),
      Mission(
        id: "3",
        title: "Quick Trivia Challenge",
        description: "Test your knowledge with 10 quick questions",
        questions: 10,
        points: 80,
        duration: "8 min",
        status: "available",
      ),
      Mission(
        id: "4",
        title: "Weekly User Survey",
        description: "Share your weekly app usage habits",
        questions: 8,
        points: 60,
        duration: "6 min",
        status: "completed",
      ),
    ]);
  }

  List<Mission> get filteredMissions {
    switch (filter.value) {
      case "available":
        return missions.where((m) => m.status == "available").toList();
      case "completed":
        return missions.where((m) => m.status == "completed").toList();
      default:
        return missions;
    }
  }

  void setFilter(String f) {
    filter.value = f;
  }

  void startMission(String id) {
    // TODO: Navigate to mission/survey flow
    Get.snackbar(
      "Mission Started",
      "Complete the questions to earn points!",
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }
}

class Mission {
  final String id;
  final String title;
  final String description;
  final int questions;
  final int points;
  final String duration;
  String status; // available, completed

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.points,
    required this.duration,
    required this.status,
  });
}
