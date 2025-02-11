import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  late final PocketBaseService _pbService;

  @override
  void initState() {
    super.initState();
    _pbService = PocketBaseService(); // Initialize PocketBaseService
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _pbService.pb.collection('users').authWithPassword(
            _emailController.text,
            _passwordController.text,
          );
      // ignore: use_build_context_synchronously
      await Future.delayed(const Duration(milliseconds: 100)); // Add delay
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } on ClientException catch (e) {
      Get.snackbar(
        '登录失败',
        e.response['message'] ?? '未知错误',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '邮箱'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入邮箱';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _loginUser();
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('登录'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('没有账号？去注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
