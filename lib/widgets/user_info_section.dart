import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/theme/app_theme.dart';

class UserInfoSection extends StatelessWidget {
  final RecordModel? userInfo;

  const UserInfoSection({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.buttonPrimary.withValues(red: 0, green: 0, blue: 0, alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            radius: 40,
            backgroundImage: userInfo?.data['avatar'] != null
                ? NetworkImage(userInfo!.data['avatar']) as ImageProvider<Object>
                : const AssetImage('assets/images/default_avatar.png'),
          ),
          const SizedBox(height: 8),
          Text(userInfo?.data['username'] ?? '用户昵称',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('已戒烟 30 天', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          const Text('累计节省 300 元，减少吸烟 600 支',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}