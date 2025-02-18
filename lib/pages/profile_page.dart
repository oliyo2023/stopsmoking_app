import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/providers/user_provider.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

/// 个人信息页面
class ProfilePage extends StatefulWidget {
  /// 构造函数
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>(); // 表单的全局 key
  final _nicknameController = TextEditingController(); // 昵称控制器
  // Add more controllers for other fields later

  bool _isLoading = false; // 是否正在加载
  late final PocketBaseService _pbService; // PocketBase 服务实例
  late RecordModel _userRecord; // 用户记录
  File? _avatarImage; // 头像图片文件
  bool _isLoggedIn = false; // 用户是否已登录

  @override
  void initState() {
    super.initState();
    _pbService = Get.find<PocketBaseService>(); // 获取 PocketBaseService 实例
    _checkLoginStatus(); // 检查登录状态
  }

  /// 检查用户登录状态
  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      // 如果用户已登录
      setState(() {
        _isLoggedIn = true; // 设置 _isLoggedIn 为 true
      });
      _fetchUserProfile(); // 获取用户资料
    } else {
      setState(() {
        _isLoggedIn = false; // 设置 _isLoggedIn 为 false
      });
    }
  }

  /// 获取用户资料
  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true; // 设置加载状态为 true
    });
    try {
      _userRecord = await _pbService.pb
          .collection('users')
          .getOne(_pbService.pb.authStore.model!.id); // 获取用户记录
      _nicknameController.text = _userRecord.data['nickname'] ?? ''; // 初始化昵称控制器
      // Initialize other controllers similarly
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white); // 显示错误提示
    } finally {
      setState(() {
        _isLoading = false; // 设置加载状态为 false
      });
    }
  }

  /// 更新用户资料
  Future<void> _updateUserProfile() async {
    setState(() {
      _isLoading = true; // 设置加载状态为 true
    });

    try {
      final updatedData = {
        'nickname': _nicknameController.text, // 更新昵称
        // Add other fields here
      };

      List<http.MultipartFile> files = [];

      // Add avatar upload to the request
      if (_avatarImage != null) {
        final bytes = await _avatarImage!.readAsBytes();
        files.add(
          http.MultipartFile.fromBytes(
            'avatar',
            bytes,
            filename: _avatarImage!.path.split('/').last,
          ),
        );
      }

      await _pbService.pb.collection('users').update(
          _pbService.pb.authStore.model!.id,
          body: updatedData,
          files: files); // 更新用户记录

      Get.snackbar('Success', 'Profile updated successfully!',
          backgroundColor: Colors.green, colorText: Colors.white); // 显示成功提示
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white); // 显示错误提示
    } finally {
      setState(() {
        _isLoading = false; // 设置加载状态为 false
      });
    }
  }

  /// 选择头像图片
  Future<void> _pickAvatarImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery); // 从图库选择图片
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path); // 更新头像图片文件
      });
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose(); // 释放昵称控制器
    // Dispose other controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人信息'),
        actions: [
          if (_isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final userProvider = Get.find<UserProvider>();
                userProvider.logout();
                setState(() {
                  _isLoggedIn = false;
                });
                Get.snackbar('提示', '已成功登出',
                    backgroundColor: Colors.green, colorText: Colors.white);
              },
            ),
        ],
      ),
      body: _isLoggedIn
          ? _buildProfileForm()
          : _buildLoginPrompt(), // 根据登录状态显示不同的内容
    );
  }

  /// 构建个人信息表单
  Widget _buildProfileForm() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator()) // 显示加载指示器
        : Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickAvatarImage, // 点击选择头像
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatarImage != null
                          ? FileImage(_avatarImage!)
                          : null, // 显示头像图片
                      child: _avatarImage == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null, // 如果没有选择头像,显示相机图标
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nicknameController, // 昵称输入框
                    decoration: const InputDecoration(labelText: '昵称'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入昵称'; // 昵称不能为空
                      }
                      return null;
                    },
                  ),
                  // Add more form fields for other profile details
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _updateUserProfile(); // 保存按钮,点击更新用户资料
                            }
                          },
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('保存'), // 根据加载状态显示不同的内容
                  ),
                ],
              ),
            ),
          );
  }

  /// 构建登录提示
  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('请先登录以查看个人信息'), // 提示用户登录
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/login'); // 跳转到登录页面
            },
            child: const Text('登录'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.toNamed('/register'); // 跳转到注册页面
            },
            child: const Text('注册'),
          ),
        ],
      ),
    );
  }
}
