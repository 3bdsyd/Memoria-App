import 'package:flutter/material.dart';
import 'choose_photo_page.dart';
import 'history_page.dart';
import '../../../../core/ui/glass_card.dart';
import '../widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFBFC5FF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryPage())),
                    icon: const Icon(Icons.history),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    // ضع صورة مثل التصميم
                    Image.asset('assets/images/home_hero.jpg', height: 210, width: double.infinity, fit: BoxFit.cover),
                    Container(
                      height: 210,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.55), Colors.transparent],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: GlassCard(
                        child: Column(
                          children: [
                            const Text('تعلّم الصور بذكاء… واستمتع بدقّة مذهلة',
                                textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            PrimaryButton(
                              label: 'اختر صورة',
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChoosePhotoPage())),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text('ماذا نقدم لك؟', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              _InfoCard(
                image: 'assets/images/home_card1.jpg',
                title: 'تحسين وإزالة التشويش',
                body: 'نستخدم تقنيات متقدمة لتحسين الحدة وتقليل الضجيج.',
              ),
              const SizedBox(height: 10),
              _InfoCard(
                image: 'assets/images/home_card2.jpg',
                title: 'مقارنة قبل/بعد',
                body: 'شاهد الفرق فورًا مع حفظ النتائج في السجل.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.image, required this.title, required this.body});
  final String image;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Image.asset(image, width: 110, height: 90, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(body, style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
