import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

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

              _buildSummaryCards(),
              SizedBox(height: 24.h),

              _buildFilterChips(),
              SizedBox(height: 16.h),

              Obx(() {
                final items = controller.filteredHistory;
                if (items.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.history, color: AppColors.textTertiary, size: 48.sp),
                          SizedBox(height: 12.h),
                          Text("No history items", style: TextStyle(color: AppColors.textTertiary, fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    Obx(() => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        "Showing ${items.length} of ${controller.history.length} items",
                        style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp, fontWeight: FontWeight.w600),
                      ),
                    )),
                    ...items.map((item) => _buildHistoryItem(item)),
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
        Text("History", style: AppTextStyles.greeting),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.bgCard2,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Earned", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                SizedBox(height: 6.h),
                Text("${controller.totalEarned}", style: TextStyle(color: AppColors.success, fontSize: 20.sp, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.bgCard2,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Spent", style: TextStyle(color: AppColors.textTertiary, fontSize: 10.sp)),
                SizedBox(height: 6.h),
                Text("${controller.totalSpent}", style: TextStyle(color: AppColors.warning, fontSize: 20.sp, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildFilterChips() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterChip("All", "all"),
            SizedBox(width: 8.w),
            _filterChip("Earned", "earned"),
            if (controller.hasRedemptions) ...[SizedBox(width: 8.w), _filterChip("Redeemed", "redeemed")],
            if (controller.hasReferrals) ...[SizedBox(width: 8.w), _filterChip("Referrals", "referral")],
          ],
        ),
      );
    });
  }

  Widget _filterChip(String label, String value) {
    final isSelected = controller.activeFilter.value == value;
    return GestureDetector(
      onTap: () => controller.activeFilter.value = value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.borderLight),
        ),
        child: Text(label, style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontSize: 12.sp, fontWeight: FontWeight.w600,
        )),
      ),
    );
  }

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
            decoration: BoxDecoration(color: item.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10.r)),
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
                style: TextStyle(color: isPositive ? AppColors.success : AppColors.warning, fontSize: 14.sp, fontWeight: FontWeight.w800),
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
