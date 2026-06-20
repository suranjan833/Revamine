import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../themes/app_colors.dart';

class ReferEarnController extends GetxController {
  final RxString referralCode = "SBS25A7F".obs;
  final RxInt totalReferrals = 5.obs;
  final RxInt referralEarnings = 150.obs;
  final RxInt inviteBonus = 50.obs;

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
        "Download the app and get $inviteBonus bonus points on signup!";
    await SharePlus.instance.share(ShareParams(text: text));
  }
}
