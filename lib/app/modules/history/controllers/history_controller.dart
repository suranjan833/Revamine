import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum HistoryType { earned, redeemed, referral }

class HistoryItem {
  final HistoryType type;
  final String title;
  final String subtitle;
  final int points;
  final String date;
  final Color color;
  final IconData icon;

  HistoryItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.date,
    required this.color,
    required this.icon,
  });
}

class HistoryController extends GetxController {
  final RxList<HistoryItem> history = <HistoryItem>[].obs;
  final RxString activeFilter = "all".obs;

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
  }

  void _loadHistory() {
    history.addAll([
      HistoryItem(type: HistoryType.earned, title: "Completed YouTube Task", subtitle: "Watched Flutter Tutorial 2025", points: 15, date: "Today, 2:30 PM", color: const Color(0xff3078FF), icon: Icons.play_circle_fill),
      HistoryItem(type: HistoryType.earned, title: "Survey: Product Feedback", subtitle: "5 questions completed", points: 50, date: "Today, 11:00 AM", color: const Color(0xffB44BFF), icon: Icons.assignment),
      HistoryItem(type: HistoryType.redeemed, title: "Amazon Gift Card - ₹250", subtitle: "Redeemed 500 points", points: -500, date: "Yesterday", color: const Color(0xffFF7A00), icon: Icons.card_giftcard),
      HistoryItem(type: HistoryType.earned, title: "App Install: Fitness App", subtitle: "Downloaded from Play Store", points: 25, date: "Yesterday", color: const Color(0xff00A86B), icon: Icons.shopify),
      HistoryItem(type: HistoryType.referral, title: "Referred a Friend", subtitle: "Friend joined via your code", points: 30, date: "3 days ago", color: const Color(0xffA855F7), icon: Icons.person_add),
      HistoryItem(type: HistoryType.earned, title: "Mission: Quick Trivia", subtitle: "10 questions answered", points: 80, date: "4 days ago", color: const Color(0xffB44BFF), icon: Icons.quiz_outlined),
      HistoryItem(type: HistoryType.redeemed, title: "Flipkart Gift Card - ₹250", subtitle: "Redeemed 500 points", points: -500, date: "1 week ago", color: const Color(0xff3078FF), icon: Icons.shopping_bag),
      HistoryItem(type: HistoryType.redeemed, title: "Google Play Code - ₹150", subtitle: "Redeemed 300 points", points: -300, date: "1 week ago", color: const Color(0xff00A86B), icon: Icons.play_circle_fill),
      HistoryItem(type: HistoryType.earned, title: "Daily Check-in Day 7", subtitle: "Weekly streak bonus", points: 50, date: "1 week ago", color: const Color(0xffFFD700), icon: Icons.calendar_month),
      HistoryItem(type: HistoryType.referral, title: "Referred a Friend", subtitle: "Friend joined via your code", points: 50, date: "2 weeks ago", color: const Color(0xffA855F7), icon: Icons.person_add),
    ]);
  }

  List<HistoryItem> get filteredHistory {
    switch (activeFilter.value) {
      case "earned":
        return history.where((h) => h.type == HistoryType.earned).toList();
      case "redeemed":
        return history.where((h) => h.type == HistoryType.redeemed).toList();
      case "referral":
        return history.where((h) => h.type == HistoryType.referral).toList();
      default:
        return history;
    }
  }

  bool get hasRedemptions => history.any((h) => h.type == HistoryType.redeemed);
  bool get hasReferrals => history.any((h) => h.type == HistoryType.referral);

  int get totalEarned => history.where((h) => h.points > 0).fold(0, (sum, h) => sum + h.points);
  int get totalSpent => history.where((h) => h.points < 0).fold(0, (sum, h) => sum + h.points.abs());
}
