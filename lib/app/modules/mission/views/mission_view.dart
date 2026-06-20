import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/mission_controller.dart';

class MissionView extends GetView<MissionController> {
  const MissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.missionPurple, Color(0xff9333EA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.quiz_outlined, color: Colors.white, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Text("Missions", style: AppTextStyles.greeting),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Complete surveys & earn big points",
                style: AppTextStyles.body,
              ),
            ),
            SizedBox(height: 20.h),

            // Filter chips
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() => Row(
                children: [
                  _buildFilterChip("All", "all"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("Available", "available"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("Completed", "completed"),
                ],
              )),
            ),
            SizedBox(height: 16.h),

            // Mission list
            Expanded(
              child: Obx(() {
                final missions = controller.filteredMissions;
                if (missions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.quiz_outlined, size: 48.sp, color: AppColors.textTertiary),
                        SizedBox(height: 12.h),
                        Text("No missions here", style: TextStyle(color: AppColors.textTertiary, fontSize: 14.sp)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: missions.length,
                  itemBuilder: (context, index) => _buildMissionCard(missions[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = controller.filter.value == value;
    return GestureDetector(
      onTap: () => controller.setFilter(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.missionPurple : AppColors.bgCard2,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.missionPurple : AppColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMissionCard(Mission mission) {
    final isCompleted = mission.status == "completed";
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgCard2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCompleted ? AppColors.success.withValues(alpha: 0.15) : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.missionPurple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.assignment, color: AppColors.missionPurple, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mission.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      mission.description,
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 11.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Icon(Icons.check_circle, color: AppColors.success, size: 22.sp),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildInfoBadge(Icons.quiz_outlined, "${mission.questions} questions"),
              SizedBox(width: 12.w),
              _buildInfoBadge(Icons.timer_outlined, mission.duration),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.missionPurple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "+${mission.points} pts",
                  style: TextStyle(
                    color: AppColors.missionPurple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (!isCompleted) ...[
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => controller.startMission(mission.id),
              child: Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.missionPurple, Color(0xff9333EA)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Start Mission",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.textTertiary, size: 12.sp),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
