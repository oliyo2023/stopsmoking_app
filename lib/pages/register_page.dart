import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
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
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _pbService.pb.collection('users').create(body: {
        'email': _emailController.text,
        'password': _passwordController.text,
        'passwordConfirm': _passwordConfirmController.text,
      });
      // ignore: use_build_context_synchronously
      await Future.delayed(const Duration(milliseconds: 100)); // Add delay
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
      Get.snackbar(
        '注册成功',
        '请登录',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on ClientException catch (e) {
      Get.snackbar(
        '注册失败',
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
        title: const Text('注册'),
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
                  // Add password strength validation if needed
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: const InputDecoration(labelText: '确认密码'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请确认密码';
                  }
                  if (value != _passwordController.text) {
                    return '两次输入的密码不一致';
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
                          _registerUser();
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
