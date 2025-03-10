import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class RecommendedArticlesSection extends StatelessWidget {
  final List<RecordModel> recommendedArticles;

  const RecommendedArticlesSection({super.key, required this.recommendedArticles});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('今日推荐',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: recommendedArticles
                  .map((article) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.data['title'] ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              article.data['summary'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/article');
                },
                child: const Text('查看更多'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}