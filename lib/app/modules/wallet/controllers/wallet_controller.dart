import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';

class WalletController extends GetxController {
  final RxInt points = 1250.obs;
  final RxInt totalEarned = 5000.obs;
  final RxInt totalRedeemed = 3750.obs;
  final RxList<RedeemOption> redeemOptions = <RedeemOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadRedeemOptions();
  }

  void _loadRedeemOptions() {
    redeemOptions.addAll([
      RedeemOption(name: "Amazon Gift Card", pointsRequired: 500, value: "₹250", icon: Icons.card_giftcard, color: const Color(0xffFF7A00)),
      RedeemOption(name: "Flipkart Gift Card", pointsRequired: 500, value: "₹250", icon: Icons.shopping_bag, color: const Color(0xff3078FF)),
      RedeemOption(name: "Amazon Gift Card", pointsRequired: 1000, value: "₹500", icon: Icons.card_giftcard, color: const Color(0xffFF7A00)),
      RedeemOption(name: "Flipkart Gift Card", pointsRequired: 1000, value: "₹500", icon: Icons.shopping_bag, color: const Color(0xff3078FF)),
      RedeemOption(name: "Paytm Cashback", pointsRequired: 200, value: "₹100", icon: Icons.account_balance_wallet, color: const Color(0xff00A86B)),
      RedeemOption(name: "Google Play Code", pointsRequired: 300, value: "₹150", icon: Icons.play_circle_fill, color: const Color(0xffB44BFF)),
    ]);
  }

  String get cashValue => "₹${(points.value * 0.5).toStringAsFixed(0)}";

  void redeem(String name, int pointsRequired) {
    if (points.value >= pointsRequired) {
      points.value -= pointsRequired;
      totalRedeemed.value += pointsRequired;
      Get.snackbar(
        "Redeemed!",
        "Successfully redeemed $name",
        backgroundColor: AppColors.success.withValues(alpha: 0.2),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "Insufficient Points",
        "You need $pointsRequired points to redeem $name",
        backgroundColor: AppColors.error.withValues(alpha: 0.2),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
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
