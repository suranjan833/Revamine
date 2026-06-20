import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<WebTask> tasks = <WebTask>[].obs;
  final RxString filter = "all".obs; // all, available, completed

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  void _loadTasks() {
    tasks.addAll([
      WebTask(
        id: "1",
        title: "Watch: Flutter Tutorial 2025",
        description: "Watch this YouTube video for 2 minutes",
        platform: "youtube",
        points: 15,
        status: "available",
        duration: "2 min",
      ),
      WebTask(
        id: "2",
        title: "Install: Fitness App",
        description: "Download & open from Play Store",
        platform: "playstore",
        points: 25,
        status: "available",
        duration: "3 min",
      ),
      WebTask(
        id: "3",
        title: "Watch: Coding Tips",
        description: "Watch this short YouTube video",
        platform: "youtube",
        points: 10,
        status: "available",
        duration: "1 min",
      ),
      WebTask(
        id: "4",
        title: "Install: Photo Editor",
        description: "Download & try the app for 30 sec",
        platform: "playstore",
        points: 20,
        status: "completed",
        duration: "2 min",
      ),
      WebTask(
        id: "5",
        title: "Watch: Productivity Hacks",
        description: "Watch and leave a comment",
        platform: "youtube",
        points: 30,
        status: "available",
        duration: "3 min",
      ),
      WebTask(
        id: "6",
        title: "Install: Note Taking App",
        description: "Download from Play Store",
        platform: "playstore",
        points: 15,
        status: "available",
        duration: "2 min",
      ),
    ]);
  }

  List<WebTask> get filteredTasks {
    switch (filter.value) {
      case "available":
        return tasks.where((t) => t.status == "available").toList();
      case "completed":
        return tasks.where((t) => t.status == "completed").toList();
      default:
        return tasks;
    }
  }

  void setFilter(String f) {
    filter.value = f;
  }

  void completeTask(String id) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx != -1 && tasks[idx].status == "available") {
      tasks[idx].status = "completed";
      tasks.refresh();
    }
  }
}

class WebTask {
  final String id;
  final String title;
  final String description;
  final String platform; // youtube, playstore
  final int points;
  String status; // available, completed
  final String duration;

  WebTask({
    required this.id,
    required this.title,
    required this.description,
    required this.platform,
    required this.points,
    required this.status,
    required this.duration,
  });
}
