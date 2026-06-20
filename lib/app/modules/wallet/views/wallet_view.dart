import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildAppBar(),
              SizedBox(height: 24.h),

              _buildBalanceHero(),
              SizedBox(height: 24.h),

              _buildStatsRow(),
              SizedBox(height: 28.h),

              Text("REDEEM POINTS", style: AppTextStyles.label),
              SizedBox(height: 12.h),

              Obx(() => Column(
                children: controller.redeemOptions
                    .map((option) => _buildRedeemOption(option))
                    .toList(),
              )),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 42.w, height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.bgNav,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white.withValues(alpha: 0.6), size: 20.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Text("My Wallet", style: AppTextStyles.greeting),
      ],
    );
  }

  Widget _buildBalanceHero() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1E2A4A), Color(0xff0F1A3A), Color(0xff0A1230)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 24.r, offset: Offset(0, 8.h))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("WALLET BALANCE", style: AppTextStyles.label),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6.w, height: 6.w, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                    SizedBox(width: 4.w),
                    Text("Active", style: TextStyle(color: AppColors.success, fontSize: 10.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${controller.points}", style: TextStyle(color: Colors.white, fontSize: 44.sp, fontWeight: FontWeight.w900, height: 0.9)),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Text("pts", style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ),
            ],
          )),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(() => Text(
              "≈ ${controller.cashValue}",
              style: TextStyle(color: AppColors.accent, fontSize: 15.sp, fontWeight: FontWeight.w700),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Earned", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                SizedBox(height: 4.h),
                Obx(() => Text("${controller.totalEarned} pts",
                    style: TextStyle(color: AppColors.success, fontSize: 18.sp, fontWeight: FontWeight.w800))),
              ],
            ),
          ),
          Container(width: 1.w, height: 40.h, color: AppColors.borderLight),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Total Redeemed", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                SizedBox(height: 4.h),
                Obx(() => Text("${controller.totalRedeemed} pts",
                    style: TextStyle(color: AppColors.warning, fontSize: 18.sp, fontWeight: FontWeight.w800))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemOption(RedeemOption option) {
    final canRedeem = controller.points >= option.pointsRequired;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: canRedeem ? AppColors.borderLight : AppColors.borderLight.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(width: 44.w, height: 44.w,
            decoration: BoxDecoration(color: option.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12.r)),
            child: Icon(option.icon, color: option.color, size: 22.sp)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option.name, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(
                  "${option.pointsRequired} points",
                  style: TextStyle(color: canRedeem ? AppColors.success : AppColors.textTertiary, fontSize: 11.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Text(option.value, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: canRedeem ? () => controller.redeem(option.name, option.pointsRequired) : null,
            child: Container(
              width: 36.w, height: 36.w,
              decoration: BoxDecoration(
                color: canRedeem ? AppColors.primary.withValues(alpha: 0.15) : AppColors.textTertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(canRedeem ? Icons.arrow_forward : Icons.lock_outline,
                  color: canRedeem ? AppColors.primary : AppColors.textTertiary, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
