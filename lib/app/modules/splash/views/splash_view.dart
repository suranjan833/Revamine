import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../themes/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          /// Static gradient background
          const _GradientBackground(),

          /// Floating particles
          const _FloatingParticles(),

          /// Main content with entry animations
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Animated logo (scale + rotate)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Transform.rotate(
                        angle: -0.3 * (1 - value),
                        child: Container(
                          width: 110.w,
                          height: 110.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryDark],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(28.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGlow,
                                blurRadius: 40.r,
                                spreadRadius: 8.r,
                                offset: Offset(0, 8.h),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              Icon(Icons.rocket_launch, color: Colors.white, size: 42.sp),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 28.h),

                /// Title fade + slide
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20.h * (1 - value)),
                        child: Text(
                          "Revamine",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),

                /// Tagline fade + slide
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 15.h * (1 - value)),
                        child: Text(
                          "Earn rewards by completing tasks",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 60.h),

                /// Loading dots — fade in then stay
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: const _LoadingDots(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ── STATIC GRADIENT BACKGROUND ──

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff020A24),
            Color(0xff0F0A2E),
          ],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}

/// ── STATIC FLOATING PARTICLES ──

class _FloatingParticles extends StatelessWidget {
  const _FloatingParticles();

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final particles = List.generate(15, (i) {
      return _ParticleData(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 1.5 + random.nextDouble() * 3,
        opacity: 0.1 + random.nextDouble() * 0.4,
      );
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _StaticParticlePainter(
            particles: particles,
            color: AppColors.primary,
          ),
        );
      },
    );
  }
}

class _ParticleData {
  final double x;
  final double y;
  final double size;
  final double opacity;

  _ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
}

class _StaticParticlePainter extends CustomPainter {
  final List<_ParticleData> particles;
  final Color color;

  _StaticParticlePainter({required this.particles, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = color.withValues(alpha: p.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StaticParticlePainter oldDelegate) => false;
}

/// ── STATIC LOADING DOTS — pulsing via TweenAnimationBuilder ──

class _LoadingDots extends StatelessWidget {
  const _LoadingDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1200),
            builder: (context, value, child) {
              // Stagger each dot
              final t = (value + index * 0.33).clamp(0.0, 1.0);
              final scale = 1.0 - (t * 0.5);
              final opacity = 0.3 + (t * 0.7);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
