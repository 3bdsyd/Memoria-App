import 'package:flutter/material.dart';
import '../../../../core/ui/glass_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _page = PageController();
  int _index = 0;

  final items = const [
    (
      image: 'assets/images/intro1.jpg',
      title: 'أعد الحياة إلى ذكرياتك',
      body:
          'وفرنا تصميم هذا التطبيق ليكون أداة سحرية تصلح الصور التالفة\nوتعيد تفاصيلها المفقودة بلمسة واحدة',
    ),
    (
      image: 'assets/images/intro2.jpg',
      title: 'أزل التشويش وأبرز اللحظة',
      body:
          'اللحظات الثمينة تستحق الوضوح… سنستخدم تقنيات ذكية لدمج\nالتشويش وخطأ الألوان لنحصل على صورة نقية وكأنها التقطت للتو',
    ),
    (
      image: 'assets/images/intro3.jpg',
      title: 'جودة واحترافية… بسهولة مطلقة',
      body:
          'ما عليك سوى تحميل صورتك… دع التشويش يرحل، لا حاجة لخبرة\nمعقدة، فقط انطلق! النتائج بين يديك في ثوان',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _page,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final it = items[i];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(it.image, fit: BoxFit.cover),
                  // تدرج بسيط مثل التصميم
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 14),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _goHome,
                          child: const Text('تخطي'),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                        child: GlassCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                it.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                it.body,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 14),
                              if (i == 0)
                                PrimaryButton(label: 'التالي', onPressed: _next)
                              else
                                Row(
                                  children: [
                                    Expanded(
                                      child: SecondaryButton(
                                        label: 'السابق',
                                        onPressed: _prev,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: i == 2 ? 'ابدأ' : 'التالي',
                                        onPressed: i == 2 ? _goHome : _next,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _next() => _page.nextPage(
    duration: const Duration(milliseconds: 260),
    curve: Curves.easeOut,
  );
  void _prev() => _page.previousPage(
    duration: const Duration(milliseconds: 260),
    curve: Curves.easeOut,
  );

  void _goHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
