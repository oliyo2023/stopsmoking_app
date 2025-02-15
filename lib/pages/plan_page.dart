import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒烟计划 (Smoking Cessation Plan)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. 设定目标 (Goal Setting)'),
            _buildPlanText(
                '• 明确戒烟日期 (Set a Quit Date): 选择一个具体的日期开始戒烟。这有助于你做好心理准备。(Choose a specific date to quit smoking. This helps you prepare mentally.)'),
            _buildPlanText(
                '• 设定长期目标 (Set Long-Term Goals): 例如，戒烟一周、一个月、三个月、一年等。 (For example, quit smoking for a week, a month, three months, a year, etc.)'),
            _buildPlanText(
                '• 设定短期目标 (Set Short-Term Goals): 例如，今天少抽一支烟，或者推迟第一支烟的时间。(For example, smoke one less cigarette today, or delay the time of your first cigarette.)'),
            _buildPlanText(
                '• 记录戒烟原因 (Record Reasons for Quitting): 写下你为什么要戒烟，例如为了健康、家人、省钱等。 (Write down why you want to quit, such as for health, family, saving money, etc.)'),
            const SizedBox(height: 16),
            _buildSectionTitle('2. 追踪进度 (Progress Tracking)'),
            _buildPlanText(
                '• 记录吸烟习惯 (Track Smoking Habits): 在戒烟前几天，记录你每天吸烟的时间、地点和原因。 (In the days leading up to quitting, record the time, place, and reason for smoking each cigarette.)'),
            _buildPlanText(
                '• 记录戒烟后的进展 (Track Progress After Quitting): 记录你每天吸烟的数量（如果还没完全戒掉）或完全不吸烟的天数。 (Record the number of cigarettes you smoke each day (if you haven\'t completely quit) or the number of days you haven\'t smoked at all.)'),
            _buildPlanText(
                '• 使用图表可视化进展 (Visualize Progress with Charts): 这将帮助你更直观地看到自己的进步。(This will help you see your progress more visually.)'),
            const SizedBox(height: 16),
            _buildSectionTitle('3. 寻求支持 (Seeking Support)'),
            _buildPlanText(
                '• 告知亲友 (Inform Friends and Family): 告诉你的家人和朋友你正在戒烟，并请求他们的支持。 (Tell your family and friends that you are quitting and ask for their support.)'),
            _buildPlanText(
                '• 加入戒烟互助小组 (Join a Support Group): 与其他戒烟者交流经验，互相鼓励。 (Connect with other quitters to share experiences and encourage each other.)'),
            _buildPlanText(
                '• 寻求专业帮助 (Seek Professional Help): 咨询医生或戒烟专家，获取专业的建议和支持。 (Consult a doctor or smoking cessation specialist for professional advice and support.)'),
            _buildPlanText(
                '• 使用App内置聊天功能 (Use in-app chat): 与AI或者其他戒烟者交流. (Chat with AI or other quitters.)'),
            const SizedBox(height: 16),
            _buildSectionTitle('4. 应对戒断症状 (Coping with Withdrawal Symptoms)'),
            _buildPlanText(
                '• 识别诱因 (Identify Triggers): 找出哪些情况会让你想吸烟，并尽量避免。 (Find out what situations make you want to smoke and try to avoid them.)'),
            _buildPlanText(
                '• 制定应对策略 (Develop Coping Strategies): 例如，深呼吸、喝水、嚼口香糖、散步、找人聊天等。 (For example, deep breathing, drinking water, chewing gum, taking a walk, talking to someone, etc.)'),
            _buildPlanText(
                '• 使用替代疗法 (Use Nicotine Replacement Therapy - NRT): 在医生指导下，使用尼古丁贴片、口香糖等帮助缓解戒断症状。 (Under the guidance of a doctor, use nicotine patches, gum, etc. to help relieve withdrawal symptoms.)'),
            _buildPlanText(
                '• 奖励自己 (Reward Yourself): 当你达成目标时，给自己一些奖励，例如看电影、买礼物等。 (When you reach your goals, give yourself some rewards, such as watching a movie, buying a gift, etc.)'),
            const SizedBox(height: 16),
            _buildSectionTitle('5. App集成建议 (App Integration Suggestions)'),
            _buildPlanText(
                '• 目标设定 (Goal Setting): 用户可以在App中设置戒烟日期、长期和短期目标，并记录戒烟原因。 (Users can set quit dates, long-term and short-term goals, and record reasons for quitting in the app.)'),
            _buildPlanText(
                '• 进度追踪 (Progress Tracking): App可以提供图表和日历视图来追踪用户的吸烟习惯和戒烟进展。 (The app can provide charts and calendar views to track users\' smoking habits and quitting progress.)'),
            _buildPlanText(
                '• 支持系统 (Support System): App可以提供内置的聊天功能，连接用户与AI戒烟助手或其他戒烟者。 (The app can provide built-in chat functionality to connect users with an AI quit-smoking assistant or other quitters.)'),
            _buildPlanText(
                '• 应对策略 (Coping Strategies): App可以根据用户的诱因，提供个性化的应对策略建议。 (The app can provide personalized coping strategy suggestions based on the user\'s triggers.)'),
            _buildPlanText(
                '• 文章/咨询 (Articles/Consultation): App 提供戒烟相关的文章和信息. (Provide articles and information related to quitting smoking.)'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPlanText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
