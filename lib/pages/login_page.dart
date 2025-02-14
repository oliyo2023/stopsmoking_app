import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.smoking_rooms,
                    size: 100, color: Colors.blue), // Placeholder logo
                const SizedBox(height: 32),
                TextFormField(
                  onChanged: (value) => controller.email.value = value,
                  decoration: InputDecoration(
                    labelText: '邮箱',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入邮箱';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) => controller.password.value = value,
                  decoration: InputDecoration(
                    labelText: '密码',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('登录')),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: const Text('没有账号？去注册'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
