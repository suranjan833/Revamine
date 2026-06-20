import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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

              _buildProfileCard(),
              SizedBox(height: 20.h),

              _buildStatsRow(),
              SizedBox(height: 28.h),

              _sectionTitle("WALLET"),
              SizedBox(height: 12.h),
              _buildWalletCard(),
              SizedBox(height: 28.h),

              _sectionTitle("SHARE & REFER"),
              SizedBox(height: 12.h),
              _buildReferCard(),
              SizedBox(height: 28.h),

              GestureDetector(
                onTap: () => Get.toNamed('/wallet'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("REDEEM POINTS", style: AppTextStyles.label),
                    Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 16.sp),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              ...controller.redeemOptions.take(2).map(_buildRedeemOption),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => Get.toNamed('/wallet'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard2,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("View All Rewards",
                            style: TextStyle(color: AppColors.primary, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                        SizedBox(width: 4.w),
                        Icon(Icons.chevron_right, color: AppColors.primary, size: 16.sp),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              GestureDetector(
                onTap: () => Get.toNamed('/history'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("HISTORY", style: AppTextStyles.label),
                    Row(
                      children: [
                        Text("View All", style: TextStyle(color: AppColors.primary, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                        SizedBox(width: 2.w),
                        Icon(Icons.chevron_right, color: AppColors.primary, size: 14.sp),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() {
                final items = controller.filteredHistory.take(3).toList();
                return Column(
                  children: [
                    ...items.map((item) => _buildHistoryItem(item)),
                    if (controller.filteredHistory.length > 3) SizedBox(height: 8.h),
                    if (controller.filteredHistory.length > 3)
                      GestureDetector(
                        onTap: () => Get.toNamed('/history'),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.bgCard2,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Center(
                            child: Text(
                              "View all ${controller.filteredHistory.length} items",
                              style: TextStyle(color: AppColors.primary, fontSize: 12.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  // ── APP BAR ──

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Profile", style: AppTextStyles.greeting),
        Row(
          children: [
            GestureDetector(
              onTap: _showEditProfileSheet,
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.bgNav,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Icon(Icons.edit_outlined, color: Colors.white.withValues(alpha: 0.6), size: 20.sp),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: controller.logout,
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.bgNav,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Icon(Icons.logout, color: Colors.white.withValues(alpha: 0.6), size: 20.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── EDIT PROFILE BOTTOM SHEET ──

  void _showEditProfileSheet() {
    controller.showEditProfile();
    Get.bottomSheet(
      _buildEditProfileSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Widget _buildEditProfileSheet() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xff151D35),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h),
          _editFieldLabel("Full Name"),
          SizedBox(height: 8.h),
          _editField(
            controller: controller.nameController,
            hint: "Enter your name",
          ),
          SizedBox(height: 16.h),
          _editFieldLabel("Email"),
          SizedBox(height: 8.h),
          _editField(
            controller: controller.emailController,
            hint: "Enter your email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 28.h),
          GestureDetector(
            onTap: controller.saveProfile,
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _editFieldLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _editField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff0A1230),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.35),
            fontSize: 14.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  // ── PROFILE CARD ──

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1A2440), Color(0xff151D35)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Obx(() => Text(
                controller.userName.value[0],
                style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w700),
              )),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(controller.userName.value, style: TextStyle(
                  color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700,
                ))),
                SizedBox(height: 4.h),
                Obx(() => Text(controller.email.value, style: TextStyle(
                  color: AppColors.textTertiary, fontSize: 12.sp,
                ))),
                SizedBox(height: 8.h),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Level ${controller.level.value}",
                    style: TextStyle(color: AppColors.primary, fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── STATS ──

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _statCard("Tasks", "${controller.tasksCompleted}", Icons.check_circle, AppColors.info)),
        SizedBox(width: 12.w),
        Expanded(child: _statCard("Missions", "${controller.missionsCompleted}", Icons.assignment, AppColors.missionPurple)),
        SizedBox(width: 12.w),
        Expanded(child: _statCard("Referred", "${controller.totalReferrals}", Icons.person_add, AppColors.primary)),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 8.h),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
          SizedBox(height: 4.h),
          Text(label, style: TextStyle(color: AppColors.textTertiary, fontSize: 9.sp),
            textAlign: TextAlign.center, maxLines: 1),
        ],
      ),
    );
  }

  // ── WALLET ──

  Widget _sectionTitle(String title) {
    return Text(title, style: AppTextStyles.label);
  }

  Widget _buildWalletCard() {
    return GestureDetector(
      onTap: () => Get.toNamed('/wallet'),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.bgCard2,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48.w, height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(Icons.account_balance_wallet, color: AppColors.success, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cash Value", style: TextStyle(color: AppColors.textTertiary, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4.h),
                      Obx(() => Text(
                        "₹${(controller.points.value * 0.5).toStringAsFixed(0)}",
                        style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800),
                      )),
                      SizedBox(height: 2.h),
                      Obx(() => Text("${controller.points} points available",
                          style: TextStyle(color: AppColors.textTertiary, fontSize: 11.sp))),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20.sp),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: AppColors.borderLight, height: 1),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Earned", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                      SizedBox(height: 4.h),
                      Obx(() => Text("${controller.totalEarned} pts",
                          style: TextStyle(color: AppColors.success, fontSize: 16.sp, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Total Redeemed", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                      SizedBox(height: 4.h),
                      Obx(() => Text("${controller.totalRedeemed} pts",
                          style: TextStyle(color: AppColors.warning, fontSize: 16.sp, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── SHARE & REFER ──

  Widget _buildReferCard() {
    return GestureDetector(
      onTap: () => Get.toNamed('/refer-earn'),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff1A2440), Color(0xff151D35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48.w, height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(Icons.share, color: AppColors.primary, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Refer & Earn", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4.h),
                      Obx(() => Text(
                        "${controller.totalReferrals} friends joined · ${controller.referralEarnings} pts earned",
                        style: TextStyle(color: AppColors.textTertiary, fontSize: 11.sp),
                      )),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── REDEEM ──

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
                Text("${option.pointsRequired} points",
                    style: TextStyle(color: canRedeem ? AppColors.success : AppColors.textTertiary, fontSize: 11.sp, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Text(option.value, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
          SizedBox(width: 12.w),
          Container(
            width: 36.w, height: 36.w,
            decoration: BoxDecoration(
              color: canRedeem ? AppColors.primary.withValues(alpha: 0.15) : AppColors.textTertiary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: GestureDetector(
              onTap: canRedeem ? () => controller.redeem(option.name) : null,
              child: Icon(canRedeem ? Icons.arrow_forward : Icons.lock_outline,
                  color: canRedeem ? AppColors.primary : AppColors.textTertiary, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── HISTORY ──

  Widget _buildHistoryItem(HistoryItem item) {
    final isPositive = item.points > 0;
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
            width: 40.w, height: 40.w,
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
                Text(item.title, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(item.subtitle, style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isPositive ? '+' : ''}${item.points}",
                style: TextStyle(
                  color: isPositive ? AppColors.success : AppColors.warning,
                  fontSize: 14.sp, fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.h),
              Text(item.date, style: TextStyle(color: AppColors.textTertiary, fontSize: 9.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
