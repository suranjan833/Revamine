import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/refer_earn_controller.dart';

class ReferEarnView extends GetView<ReferEarnController> {
  const ReferEarnView({super.key});

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

              _buildHeroSection(),
              SizedBox(height: 24.h),

              _buildReferralCodeCard(),
              SizedBox(height: 28.h),

              _buildStatsSection(),
              SizedBox(height: 28.h),

              _buildHowItWorks(),
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
        Text("Refer & Earn", style: AppTextStyles.greeting),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff7C3AED), Color(0xff4C1D95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff7C3AED).withValues(alpha: 0.25),
            blurRadius: 24.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64.w, height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people_alt_outlined, color: Colors.white, size: 30.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            "Invite Friends, Earn Together",
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800, letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "Share your referral code and earn ${controller.inviteBonus} bonus points for each friend who joins!",
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: controller.shareReferralCode,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: const Color(0xff7C3AED), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text("Invite Friends", style: TextStyle(color: const Color(0xff7C3AED), fontSize: 15.sp, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCodeCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Text("YOUR REFERRAL CODE", style: AppTextStyles.label),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.loyalty, color: AppColors.primary, size: 24.sp),
                SizedBox(width: 12.w),
                Obx(() => Expanded(
                  child: Text(
                    controller.referralCode.value,
                    style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w900, letterSpacing: 3),
                  ),
                )),
                GestureDetector(
                  onTap: controller.copyReferralCode,
                  child: Container(
                    width: 40.w, height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.copy, color: AppColors.primary, size: 20.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(child: _statCard("Friends Joined", "${controller.totalReferrals}", Icons.person_add, AppColors.primary)),
        SizedBox(width: 12.w),
        Expanded(child: _statCard("Points Earned", "${controller.referralEarnings}", Icons.monetization_on, AppColors.success)),
        SizedBox(width: 12.w),
        Expanded(child: _statCard("Reward per Friend", "${controller.inviteBonus}", Icons.card_giftcard, AppColors.warning)),
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
          Text(label, style: TextStyle(color: AppColors.textTertiary, fontSize: 9.sp), textAlign: TextAlign.center, maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("HOW IT WORKS", style: AppTextStyles.label),
          SizedBox(height: 16.h),
          _stepItem(1, "Share", "Share your unique referral code with friends via WhatsApp, Telegram, or any app."),
          SizedBox(height: 12.h),
          _stepItem(2, "Friend Joins", "Your friend downloads Revamine and enters your code during signup."),
          SizedBox(height: 12.h),
          _stepItem(3, "You Both Earn", "You get ${controller.inviteBonus} bonus points and your friend gets 25 bonus points instantly!"),
        ],
      ),
    );
  }

  Widget _stepItem(int step, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.w, height: 28.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
            shape: BoxShape.circle,
          ),
          child: Center(child: Text("$step", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w800))),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 4.h),
              Text(description, style: TextStyle(color: AppColors.textTertiary, fontSize: 11.sp, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}
