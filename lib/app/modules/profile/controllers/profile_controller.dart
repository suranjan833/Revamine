import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../themes/app_colors.dart';

class ProfileController extends GetxController {
  final RxString userName = "SBS".obs;
  final RxString email = "sbs@example.com".obs;
  final RxInt points = 1250.obs;
  final RxInt tasksCompleted = 47.obs;
  final RxInt missionsCompleted = 12.obs;
  final RxInt level = 1.obs;
  final RxString memberSince = "Jan 2025".obs;

  // Referral
  final RxString referralCode = "SBS25A7F".obs;
  final RxInt totalReferrals = 5.obs;
  final RxInt referralEarnings = 150.obs;

  // Wallet totals
  final RxInt totalEarned = 5000.obs;
  final RxInt totalRedeemed = 3750.obs;

  // History
  final RxList<HistoryItem> history = <HistoryItem>[].obs;
  final RxString historyFilter = "all".obs;

  // Edit profile controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void _loadHistory() {
    history.addAll([
      HistoryItem(
        type: HistoryType.earned,
        title: "Completed YouTube Task",
        subtitle: "Watched Flutter Tutorial 2025",
        points: 15,
        date: "Today, 2:30 PM",
        color: const Color(0xff3078FF),
        icon: Icons.play_circle_fill,
      ),
      HistoryItem(
        type: HistoryType.earned,
        title: "Survey: Product Feedback",
        subtitle: "5 questions completed",
        points: 50,
        date: "Today, 11:00 AM",
        color: const Color(0xffB44BFF),
        icon: Icons.assignment,
      ),
      HistoryItem(
        type: HistoryType.redeemed,
        title: "Amazon Gift Card - ₹250",
        subtitle: "Redeemed 500 points",
        points: -500,
        date: "Yesterday",
        color: const Color(0xffFF7A00),
        icon: Icons.card_giftcard,
      ),
      HistoryItem(
        type: HistoryType.earned,
        title: "App Install: Fitness App",
        subtitle: "Downloaded from Play Store",
        points: 25,
        date: "Yesterday",
        color: const Color(0xff00A86B),
        icon: Icons.shopify,
      ),
      HistoryItem(
        type: HistoryType.referral,
        title: "Referred a Friend",
        subtitle: "Friend joined via your code",
        points: 30,
        date: "3 days ago",
        color: const Color(0xffA855F7),
        icon: Icons.person_add,
      ),
      HistoryItem(
        type: HistoryType.earned,
        title: "Mission: Quick Trivia",
        subtitle: "10 questions answered",
        points: 80,
        date: "4 days ago",
        color: const Color(0xffB44BFF),
        icon: Icons.quiz_outlined,
      ),
      HistoryItem(
        type: HistoryType.redeemed,
        title: "Flipkart Gift Card - ₹250",
        subtitle: "Redeemed 500 points",
        points: -500,
        date: "1 week ago",
        color: const Color(0xff3078FF),
        icon: Icons.shopping_bag,
      ),
    ]);
  }

  List<HistoryItem> get filteredHistory {
    switch (historyFilter.value) {
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

  // ── REFERRAL ──

  void copyReferralCode() {
    Clipboard.setData(ClipboardData(text: referralCode.value));
    Get.snackbar(
      "Copied!",
      "Referral code copied to clipboard",
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> shareReferralCode() async {
    final text = "Join Revamine and earn rewards! Use my referral code: ${referralCode.value}. "
        "Download the app and get 50 bonus points on signup!";
    await SharePlus.instance.share(
      ShareParams(text: text),
    );
  }

  // ── EDIT PROFILE ──

  void showEditProfile() {
    nameController.text = userName.value;
    emailController.text = email.value;
  }

  void saveProfile() {
    if (nameController.text.isNotEmpty) {
      userName.value = nameController.text;
    }
    if (emailController.text.isNotEmpty) {
      email.value = emailController.text;
    }
    Get.back();
    Get.snackbar(
      "Profile Updated",
      "Your changes have been saved",
      backgroundColor: AppColors.success.withValues(alpha: 0.2),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // ── REDEEM ──

  List<RedeemOption> get redeemOptions => [
    RedeemOption(
      name: "Amazon Gift Card",
      pointsRequired: 500,
      value: "₹250",
      icon: Icons.card_giftcard,
      color: const Color(0xffFF7A00),
    ),
    RedeemOption(
      name: "Flipkart Gift Card",
      pointsRequired: 500,
      value: "₹250",
      icon: Icons.shopping_bag,
      color: const Color(0xff3078FF),
    ),
    RedeemOption(
      name: "Amazon Gift Card",
      pointsRequired: 1000,
      value: "₹500",
      icon: Icons.card_giftcard,
      color: const Color(0xffFF7A00),
    ),
    RedeemOption(
      name: "Flipkart Gift Card",
      pointsRequired: 1000,
      value: "₹500",
      icon: Icons.shopping_bag,
      color: const Color(0xff3078FF),
    ),
  ];

  void redeem(String name) {
    Get.snackbar(
      "Redeem",
      "Coming soon: $name redemption",
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  // ── LOGOUT ──

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      titleStyle: const TextStyle(color: Colors.white),
      backgroundColor: const Color(0xff151D35),
      middleText: "Are you sure you want to logout?",
      middleTextStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
      confirm: GestureDetector(
        onTap: () {
          Get.back();
          Get.offAllNamed('/login');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xffEF4444).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Logout", style: TextStyle(color: Color(0xffEF4444), fontWeight: FontWeight.w600)),
        ),
      ),
      cancel: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Cancel", style: TextStyle(color: Color(0xffA855F7), fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

// ── MODELS ──

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

class RedeemOption {
  final String name;
  final int pointsRequired;
  final String value;
  final IconData icon;
  final Color color;

  RedeemOption({
    required this.name,
    required this.pointsRequired,
    required this.value,
    required this.icon,
    required this.color,
  });
}
