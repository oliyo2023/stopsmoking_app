import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  // Add more controllers for other fields later

  bool _isLoading = false;
  late final PocketBaseService _pbService;
  late RecordModel _userRecord;
  File? _avatarImage; // To store the selected avatar image
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _pbService = PocketBaseService();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      setState(() {
        _isLoggedIn = true;
      });
      _fetchUserProfile();
    } else {
      setState(() {
        _isLoggedIn = false;
      });
    }
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _userRecord = await _pbService.pb
          .collection('users')
          .getOne(_pbService.pb.authStore.model!.id);
      _nicknameController.text =
          _userRecord.data['nickname'] ?? ''; // Initialize with existing data
      // Initialize other controllers similarly
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updatedData = {
        'nickname': _nicknameController.text,
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
          files: files);

      Get.snackbar('Success', 'Profile updated successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickAvatarImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    // Dispose other controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人信息'),
      ),
      body: _isLoggedIn ? _buildProfileForm() : _buildLoginPrompt(),
    );
  }

  Widget _buildProfileForm() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickAvatarImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatarImage != null
                          ? FileImage(_avatarImage!)
                          : null,
                      child: _avatarImage == null
                          ? Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: '昵称'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入昵称';
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
                              _updateUserProfile();
                            }
                          },
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('保存'),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('请先登录以查看个人信息'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/login');
            },
            child: Text('登录'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.toNamed('/register');
            },
            child: const Text('注册'),
          ),
        ],
      ),
    );
  }
}
