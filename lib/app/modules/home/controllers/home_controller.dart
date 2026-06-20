import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // ── Wallet ──
  final RxInt walletBalance = 1250.obs;
  final RxInt totalEarned = 5000.obs;
  final RxInt totalRedeemed = 3750.obs;
  final RxString cashValue = "₹625".obs;

  // ── Daily Stats ──
  final RxInt todayEarnings = 45.obs;
  final RxInt tasksCompleted = 3.obs;
  final RxInt totalTasks = 8.obs;

  // ── Level ──
  final RxInt level = 1.obs;
  final RxDouble levelProgress = 0.35.obs;
  final RxString levelTitle = "Bronze".obs;

  // ── User ──
  final RxString userName = "SBS".obs;

  // ── Daily Check-in ──
  final RxBool canCheckIn = true.obs;
  final RxInt checkInStreak = 0.obs;
  final RxBool showCheckInDialog = false.obs;
  final RxInt checkInBonus = 10.obs;
  String _lastCheckInDate = "";

  // Recent activity
  final RxList<ActivityItem> recentActivities = <ActivityItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadRecentActivity();
    _checkDailyCheckIn();
  }

  void _checkDailyCheckIn() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (_lastCheckInDate != today) {
      canCheckIn.value = true;
      showCheckInDialog.value = true;
      Future.delayed(const Duration(milliseconds: 600), () {
        if (showCheckInDialog.value) {
          _showCheckInPopup();
        }
      });
    } else {
      canCheckIn.value = false;
    }
  }

  void claimCheckIn() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    _lastCheckInDate = today;

    checkInStreak.value++;
    checkInBonus.value = 10 + (checkInStreak.value - 1) * 2;
    if (checkInBonus.value > 50) checkInBonus.value = 50;

    walletBalance.value += checkInBonus.value;
    totalEarned.value += checkInBonus.value;
    todayEarnings.value += checkInBonus.value;
    cashValue.value = "₹${(walletBalance.value * 0.5).toStringAsFixed(0)}";

    canCheckIn.value = false;
    showCheckInDialog.value = false;

    recentActivities.insert(
      0,
      ActivityItem(
        icon: Icons.calendar_month,
        title: "Daily Check-in Day ${checkInStreak.value}",
        subtitle: "+${checkInBonus.value} points",
        color: const Color(0xff00A86B),
        time: "Just now",
      ),
    );

    Get.back();
    Get.snackbar(
      "Check-in Complete! 🔥",
      "You earned ${checkInBonus.value} points! Day ${checkInStreak.value} streak!",
      backgroundColor: const Color(0xff00A86B).withValues(alpha: 0.2),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void dismissCheckIn() {
    showCheckInDialog.value = false;
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void _showCheckInPopup() {
    Get.dialog(
      CheckInDialogContent(
        streak: checkInStreak.value,
        bonus: checkInBonus.value,
        onClaim: claimCheckIn,
        onDismiss: dismissCheckIn,
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff050510).withValues(alpha: 0.85),
    );
  }

  void _loadRecentActivity() {
    recentActivities.addAll([
      ActivityItem(
        icon: Icons.check_circle,
        title: "Completed YouTube Task",
        subtitle: "+15 points",
        color: const Color(0xff3078FF),
        time: "2 min ago",
      ),
      ActivityItem(
        icon: Icons.quiz_outlined,
        title: "Completed Survey #3",
        subtitle: "+30 points",
        color: const Color(0xffB44BFF),
        time: "1 hour ago",
      ),
      ActivityItem(
        icon: Icons.card_giftcard,
        title: "Redeemed ₹50 Gift Card",
        subtitle: "-500 points",
        color: const Color(0xffFF7A00),
        time: "2 days ago",
      ),
    ]);
  }
}

class ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String time;

  ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.time,
  });
}

// ══════════════════════════════════════════════════════════════════════
// DAILY CHECK-IN DIALOG — StatelessWidget
// ══════════════════════════════════════════════════════════════════════

class CheckInDialogContent extends StatelessWidget {
  final int streak;
  final int bonus;
  final VoidCallback onClaim;
  final VoidCallback onDismiss;

  const CheckInDialogContent({
    super.key,
    required this.streak,
    required this.bonus,
    required this.onClaim,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            gradient: const LinearGradient(
              colors: [Color(0xff0D0A1A), Color(0xff1A0E30), Color(0xff0D0A1A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff6C2BD9).withValues(alpha: 0.25),
                blurRadius: 60.r,
                spreadRadius: 8.r,
                offset: Offset(0, 16.h),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 40.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildStreakCalendar(),
              SizedBox(height: 20.h),
              _buildPointsReward(),
              SizedBox(height: 24.h),
              _buildClaimButton(),
              SizedBox(height: 14.h),
              _buildDismissButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 36.h, 24.w, 28.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff7C3AED), Color(0xff6D28D9), Color(0xff4C1D95)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffFFD700),
                    Color(0xffFF8C00),
                    Color(0xffFF4500),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD700).withValues(alpha: 0.4),
                    blurRadius: 25.r,
                    spreadRadius: 6.r,
                  ),
                  BoxShadow(
                    color: const Color(0xffFF8C00).withValues(alpha: 0.25),
                    blurRadius: 50.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 36),
              ),
            ),
            SizedBox(height: 18.h),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Color(0xffD8B4FE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                "Daily Check-in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Don't break your streak!",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("🔥", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 6.w),
                  Text(
                    "Day ${streak + 1} Streak",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCalendar() {
    final today = DateTime.now();
    final currentDay = today.weekday - 1;
    final dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: const Color(0xffFF6B6B).withValues(alpha: 0.7),
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                "This Week",
                style: TextStyle(
                  color: const Color(0xffD8B4FE),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Text(
                "+$bonus pts",
                style: TextStyle(
                  color: const Color(0xffFFD700),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final isToday = index == currentDay;
              final isPast = index < currentDay;
              final isFuture = index > currentDay;
              final isCheckedIn = isPast && index < streak;
              final isTodayChecked = isToday && streak > 0;

              Color borderColor;
              final Widget child;

              if (isCheckedIn || isTodayChecked) {
                borderColor = const Color(0xffA855F7);
                child = Icon(Icons.check, color: Colors.white, size: 14.sp);
              } else if (isToday) {
                borderColor = const Color(0xffA855F7);
                child = Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                  ),
                );
              } else if (isFuture) {
                borderColor = const Color(0xffA855F7).withValues(alpha: 0.08);
                child = Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              } else {
                borderColor = const Color(0xffEF4444).withValues(alpha: 0.08);
                child = Icon(
                  Icons.close_rounded,
                  color: const Color(0xffEF4444).withValues(alpha: 0.25),
                  size: 12.sp,
                );
              }

              final circleSize = isToday ? 42.w : 36.w;
              final isFilled = isCheckedIn || isTodayChecked;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: isFilled
                          ? const Color(0xff7C3AED)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor,
                        width: isFilled ? 0 : (isToday ? 2.0 : 1.0),
                      ),
                      boxShadow: isToday
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xff7C3AED,
                                ).withValues(alpha: 0.25),
                                blurRadius: 12.r,
                                spreadRadius: 1.r,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(child: child),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    dayNames[index],
                    style: TextStyle(
                      color: isToday
                          ? const Color(0xffD8B4FE)
                          : Colors.white.withValues(alpha: 0.55),
                      fontSize: 10.sp,
                      fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsReward() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff7C3AED).withValues(alpha: 0.08),
            const Color(0xff4C1D95).withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xff7C3AED).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xffFFD700), Color(0xffFF8C00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffFFD700).withValues(alpha: 0.25),
                  blurRadius: 12.r,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.star, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xffFFD700), Color(0xffFF8C00)],
                ).createShader(bounds),
                child: Text(
                  "+$bonus points",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    height: 0.95,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Streak bonus included",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: _PremiumButton(label: "Claim Reward", onTap: onClaim),
    );
  }

  Widget _buildDismissButton() {
    return GestureDetector(
      onTap: onDismiss,
      child: Padding(
        padding: EdgeInsets.only(bottom: 28.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            "Maybe later",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ── PREMIUM BUTTON — StatelessWidget ──

class _PremiumButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PremiumButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff7C3AED), Color(0xff6D28D9), Color(0xff5B21B6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff7C3AED).withValues(alpha: 0.4),
              blurRadius: 24.r,
              spreadRadius: 4.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white.withValues(alpha: 0.9),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
