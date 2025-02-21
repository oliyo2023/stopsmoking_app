import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('个人中心',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              // TODO: 实现设置页面导航
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfoSection(),
            _buildMembershipCard(),
            _buildServiceSection(),
            _buildHealthServiceSection(),
            _buildLiveServiceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
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
                const Text(
                  '布朗熊大宝',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
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
                    TextButton(
                      onPressed: () {
                        // TODO: 实现编辑资料功能
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

  Widget _buildMembershipCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.blue[300]!.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '现在加入 Blued 会员',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            '限时！VIP 最低 9 折～',
            // ignore: deprecated_member_use
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: 实现加入会员功能
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

  Widget _buildServiceSection() {
    return _buildServiceGroup(
      title: '我的服务',
      items: [
        ServiceItem(Icons.monetization_on_outlined, '鸣豆 7986', Colors.orange),
        ServiceItem(Icons.call_outlined, '呼唤', Colors.green),
        ServiceItem(Icons.camera_alt_outlined, '彩子特权包', Colors.purple),
        ServiceItem(Icons.star_border_outlined, '超级曝光', Colors.blue),
      ],
    );
  }

  Widget _buildHealthServiceSection() {
    return _buildServiceGroup(
      title: '健康服务',
      items: [
        ServiceItem(Icons.local_hospital_outlined, '健康药房', Colors.red),
        ServiceItem(Icons.favorite_border, '性感好物', Colors.pink),
        ServiceItem(Icons.volunteer_activism_outlined, '淡蓝公益', Colors.blue),
        ServiceItem(Icons.medical_services_outlined, 'HIV预约', Colors.teal),
      ],
    );
  }

  Widget _buildLiveServiceSection() {
    return _buildServiceGroup(
      title: '直播服务',
      items: [
        ServiceItem(Icons.star_border_outlined, '主播等级', Colors.amber),
        ServiceItem(Icons.people_outline, '主播报表', Colors.indigo),
        ServiceItem(Icons.group_outlined, '粉丝团', Colors.deepPurple),
        ServiceItem(
            Icons.account_balance_wallet_outlined, '财富等级', Colors.green),
      ],
    );
  }

  Widget _buildServiceGroup(
      {required String title, required List<ServiceItem> items}) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
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

class ServiceItem {
  final IconData icon;
  final String label;
  final Color color;

  ServiceItem(this.icon, this.label, this.color);
}
