import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isSignupLoading = false.obs;
  final isLoginLoading = false.obs;

  // Login / Signup toggle text
  final isLoginMode = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleMode() {
    isLoginMode.toggle();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
      return;
    }
    isLoginLoading.value = true;
    // TODO: Implement actual authentication
    await Future.delayed(const Duration(seconds: 1));
    isLoginLoading.value = false;
    Get.offNamed('/main');
  }

  Future<void> signup() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
      return;
    }
    isSignupLoading.value = true;
    // TODO: Implement actual signup
    await Future.delayed(const Duration(seconds: 1));
    isSignupLoading.value = false;
    Get.offNamed('/main');
  }
}
