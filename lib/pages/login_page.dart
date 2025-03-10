import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/providers/user_provider.dart';
import 'package:jieyan_app/theme/app_theme.dart';

class LoginPage extends GetView<UserProvider> {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isLoading = false.obs;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;
      try {
        await controller.login(
          _emailController.text,
          _passwordController.text,
        );
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar(
          '登录失败',
          e.toString(),
          backgroundColor: AppColors.snackbarError,
          colorText: AppColors.snackbarText,
        );
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '邮箱',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入邮箱';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return '请输入有效的邮箱地址';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '密码',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading.value ? null : _login,
                      child: _isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('登录'),
                    ),
                  )),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text('没有账号？立即注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
