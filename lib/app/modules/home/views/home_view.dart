import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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

              _buildHeader(),
              SizedBox(height: 20.h),

              _buildWalletHero(),
              SizedBox(height: 20.h),

              Obx(() => _buildCheckInCard()),
              SizedBox(height: 24.h),

              _buildProgressHeader(),
              SizedBox(height: 12.h),
              _buildProgressCard(),
              SizedBox(height: 28.h),

              _buildSectionTitle("RECENT ACTIVITY"),
              SizedBox(height: 12.h),
              Obx(
                () => Column(
                  children: controller.recentActivities
                      .map((a) => _buildActivityItem(a))
                      .toList(),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ── HEADER ──

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGlow,
                blurRadius: 12.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Center(
            child: Obx(
              () => Text(
                controller.userName.value[0],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back,", style: AppTextStyles.body),
              SizedBox(height: 2.h),
              Obx(
                () => Text(
                  "${controller.userName}!",
                  style: AppTextStyles.greeting,
                ),
              ),
            ],
          ),
        ),
        _buildIconButton(Icons.notifications_none, badge: true),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, {bool badge = false}) {
    return Stack(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: AppColors.bgNav,
            borderRadius: BorderRadius.circular(21.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.7),
            size: 20.sp,
          ),
        ),
        if (badge)
          Positioned(
            right: 9.w,
            top: 9.w,
            child: Container(
              width: 7.w,
              height: 7.w,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  // ── WALLET HERO ──

  Widget _buildWalletHero() {
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("WALLET BALANCE", style: AppTextStyles.label),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Active",
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.walletBalance}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.sp,
                    fontWeight: FontWeight.w900,
                    height: 0.9,
                  ),
                ),
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Text(
                    "pts",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                "≈ ${controller.cashValue}",
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _walletStat(
                    "Today",
                    "+${controller.todayEarnings}",
                    AppColors.success,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 32.h,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                Expanded(
                  child: _walletStat(
                    "Earned",
                    "${controller.totalEarned}",
                    AppColors.info,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 32.h,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                Expanded(
                  child: _walletStat(
                    "Redeemed",
                    "${controller.totalRedeemed}",
                    AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp),
        ),
      ],
    );
  }

  // ── DAILY CHECK-IN CARD ──

  Widget _buildCheckInCard() {
    if (!controller.canCheckIn.value) {
      return Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColors.bgCard2,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.checkinGreen.withValues(alpha: .3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.checkinGreen.withValues(alpha: .15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.checkinGreen,
                size: 30,
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily Reward Claimed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Obx(
                    () => Text(
                      "🔥 ${controller.checkInStreak} Day Streak Active",
                      style: TextStyle(
                        color: AppColors.checkinGreen,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Text(
                    "Come back tomorrow for more rewards",
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.checkinGreen,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "CLAIMED",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: controller.claimCheckIn,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffFFB800), Color(0xffFF7A00)],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: .35),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            /// Reward Icon
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 34,
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "FREE DAILY REWARD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Obx(
                    () => Text(
                      "+${controller.checkInBonus} POINTS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Obx(
                    () => Text(
                      "Day ${controller.checkInStreak + 1} Streak Bonus",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .9),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Text(
                "CLAIM",
                style: TextStyle(
                  color: Color(0xffFF7A00),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ── LEVEL PROGRESS ──

  Widget _buildProgressHeader() {
    return Text("LEVEL PROGRESS", style: AppTextStyles.label);
  }

  Widget _buildProgressCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [Color(0xff1E2A4A), Color(0xff151D35)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Obx(
                () => Text(
                  "LEVEL ${controller.level}",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.workspace_premium_outlined,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Obx(
                () => Text(
                  controller.levelTitle.value,
                  style: AppTextStyles.heading.copyWith(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "${(controller.levelProgress.value * 100).toInt()}%",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: LinearProgressIndicator(
                      value: controller.levelProgress.value,
                      minHeight: 6.h,
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.12),
                  ),
                  child: Obx(
                    () => Center(
                      child: Text(
                        "${(controller.levelProgress.value * 100).toInt()}%",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Next: Silver",
                style: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 10.sp,
                ),
              ),
              Obx(
                () => Text(
                  "${((1.0 - controller.levelProgress.value) * 100).toInt()} pts to go",
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── ACTIVITY ──

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.label);
  }

  Widget _buildActivityItem(ActivityItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(item.icon, color: item.color, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: item.color,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item.time,
            style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}
