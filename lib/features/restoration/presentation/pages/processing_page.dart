import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restoration_bloc.dart';
import 'result_page.dart';

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({super.key});

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestorationBloc, RestorationState>(
      listenWhen: (p, n) => p.status != n.status,
      listener: (context, state) {
        if (state.status == RestoreStatus.done && state.currentJob != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultPage()));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('التحسين'), backgroundColor: Colors.transparent, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<RestorationBloc, RestorationState>(
            builder: (context, state) {
              final (step, title) = switch (state.status) {
                RestoreStatus.uploading => ('1.0', 'نرفع الصورة للخادم...'),
                RestoreStatus.downloadingEnhanced => ('1.1', 'نحسّن التفاصيل ونزيل التشويش...'),
                RestoreStatus.downloadingCompare => ('1.2', 'نجهّز المقارنة النهائية...'),
                _ => ('', 'جاري المعالجة...'),
              };

              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        color: Colors.black.withOpacity(0.08),
                        child: AnimatedBuilder(
                          animation: _c,
                          builder: (_, __) {
                            return CustomPaint(
                              painter: _StarsPainter(_c.value),
                              child: Center(
                                child: Text(step, style: TextStyle(color: Colors.black.withOpacity(0.45), fontSize: 26, fontWeight: FontWeight.w800)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  _StarsPainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF4F73FF);
    final rnd = Random(7);
    for (int i = 0; i < 12; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final r = 1.8 + (sin((t * 2 * pi) + i) + 1) * 1.2;
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter oldDelegate) => oldDelegate.t != t;
}
