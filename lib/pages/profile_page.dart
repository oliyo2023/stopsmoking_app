import 'package:flutter/material.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:jieyan_app/pages/settings_page.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/app_routes.dart';

/// 个人中心页面
/// 展示用户个人信息、会员卡片和各类服务入口
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('个人中心',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18)),
        actions: [
          // 设置按钮
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textSecondary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfoSection(), // 用户信息区域
            _buildMembershipCard(), // 会员卡片区域
            _buildServiceSection(), // 我的服务区域
            _buildHealthServiceSection(), // 健康服务区域
            _buildLiveServiceSection(), // 直播服务区域
          ],
        ),
      ),
    );
  }

  /// 构建用户信息区域
  /// 包含用户头像、昵称、彩虹分和编辑资料按钮
  Widget _buildUserInfoSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // 用户头像
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!, width: 2),
              image: const DecorationImage(
                image: AssetImage('assets/images/default_avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户昵称
                const Text(
                  '布朗熊大宝',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // 彩虹分显示
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.blue[600]),
                          const SizedBox(width: 4),
                          Text('彩虹分: 99',
                              style: TextStyle(
                                  color: Colors.blue[600], fontSize: 13)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 编辑资料按钮
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.editProfile); // Navigate to Edit Profile page
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('编辑资料',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建会员卡片区域
  /// 展示会员优惠信息和加入会员按钮
  Widget _buildMembershipCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.membershipGradientStart,
            AppColors.membershipGradientEnd
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[300]!
                .withValues(red: 0, green: 0, blue: 0, alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 会员标题
          const Text(
            '现在加入 Blued 会员',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          // 优惠信息
          Text(
            '限时！VIP 最低 9 折～',
            style: TextStyle(
                color: Colors.white
                    .withValues(red: 255, green: 255, blue: 255, alpha: 0.8),
                fontSize: 14),
          ),
          const SizedBox(height: 20),
          // 加入会员按钮
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.membership); // Navigate to Membership page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1565C0),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('加入会员',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// 构建我的服务区域
  /// 展示鸣豆、呼唤等功能入口
  Widget _buildServiceSection() {
    return _buildServiceGroup(
      title: '我的服务',
      items: [
        ServiceItem(
            Icons.monetization_on_outlined, '鸣豆 7986', AppColors.serviceOrange),
        ServiceItem(Icons.call_outlined, '呼唤', AppColors.serviceGreen),
        ServiceItem(
            Icons.camera_alt_outlined, '彩子特权包', AppColors.servicePurple),
        ServiceItem(Icons.star_border_outlined, '超级曝光', AppColors.serviceBlue),
      ],
    );
  }

  /// 构建健康服务区域
  /// 展示健康药房、性感好物等功能入口
  Widget _buildHealthServiceSection() {
    return _buildServiceGroup(
      title: '健康服务',
      items: [
        ServiceItem(
            Icons.local_hospital_outlined, '健康药房', AppColors.serviceRed),
        ServiceItem(Icons.favorite_border, '性感好物', AppColors.servicePink),
        ServiceItem(
            Icons.volunteer_activism_outlined, '淡蓝公益', AppColors.serviceBlue),
        ServiceItem(
            Icons.medical_services_outlined, 'HIV预约', AppColors.serviceTeal),
      ],
    );
  }

  /// 构建直播服务区域
  /// 展示主播等级、主播报表等功能入口
  Widget _buildLiveServiceSection() {
    return _buildServiceGroup(
      title: '直播服务',
      items: [
        ServiceItem(Icons.star_border_outlined, '主播等级', AppColors.serviceAmber),
        ServiceItem(Icons.people_outline, '主播报表', AppColors.serviceIndigo),
        ServiceItem(Icons.group_outlined, '粉丝团', AppColors.serviceDeepPurple),
        ServiceItem(Icons.account_balance_wallet_outlined, '财富等级',
            AppColors.serviceGreen),
      ],
    );
  }

  /// 构建服务组件
  /// @param title 服务组标题
  /// @param items 服务项列表
  Widget _buildServiceGroup(
      {required String title, required List<ServiceItem> items}) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 服务组标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          // 服务项网格
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            mainAxisSpacing: 16,
            children: items.map((item) => _buildServiceItem(item)).toList(),
          ),
        ],
      ),
    );
  }

  /// 构建单个服务项
  /// @param item 服务项数据
  Widget _buildServiceItem(ServiceItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, size: 28, color: item.color),
        const SizedBox(height: 8),
        Text(
          item.label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// 服务项数据模型
/// @param icon 图标
/// @param label 标签文本
/// @param color 图标颜色
class ServiceItem {
  final IconData icon;
  final String label;
  final Color color;

  ServiceItem(this.icon, this.label, this.color);
}
