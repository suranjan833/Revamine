import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

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
                        colors: [Color(0xff3078FF), Color(0xff2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.check_circle_outline, color: Colors.white, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Text("Web Tasks", style: AppTextStyles.greeting),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Complete tasks and earn points",
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

            // Task list
            Expanded(
              child: Obx(() {
                final tasks = controller.filteredTasks;
                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 48.sp, color: AppColors.textTertiary),
                        SizedBox(height: 12.h),
                        Text("No tasks here", style: TextStyle(color: AppColors.textTertiary, fontSize: 14.sp)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => _buildTaskCard(tasks[index]),
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
          color: isSelected ? AppColors.primary : AppColors.bgCard2,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
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

  Widget _buildTaskCard(WebTask task) {
    final isCompleted = task.status == "completed";
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.bgCard2.withValues(alpha: 0.6) : AppColors.bgCard2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCompleted ? AppColors.success.withValues(alpha: 0.15) : AppColors.borderLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: task.platform == "youtube"
                  ? Colors.red.withValues(alpha: 0.15)
                  : AppColors.checkinGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              task.platform == "youtube" ? Icons.play_circle_fill : Icons.shopify,
              color: task.platform == "youtube" ? Colors.red : AppColors.checkinGreen,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  task.description,
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 11.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "+${task.points} pts",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.timer_outlined, color: AppColors.textTertiary, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      task.duration,
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (isCompleted)
            Icon(Icons.check_circle, color: AppColors.success, size: 22.sp)
          else
            GestureDetector(
              onTap: () => controller.completeTask(task.id),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.play_arrow, color: AppColors.primary, size: 20.sp),
              ),
            ),
        ],
      ),
    );
  }
}
