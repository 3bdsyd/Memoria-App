import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restoration_bloc.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final job = context.select((RestorationBloc b) => b.state.currentJob);
    if (job == null) return const Scaffold(body: Center(child: Text('لا توجد بيانات')));

    return Scaffold(
      appBar: AppBar(title: const Text('مقارنة قبل/بعد')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('معاينة الفرق بين الصورتين', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _SideCard(label: 'قبل', color: const Color(0xFFB91C1C), file: File(job.originalPath))),
                  const SizedBox(width: 12),
                  Expanded(child: _SideCard(label: 'بعد', color: const Color(0xFF16A34A), file: File(job.enhancedPath!))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('الصورة المحسّنة النهائية'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({required this.label, required this.color, required this.file});
  final String label;
  final Color color;
  final File file;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Positioned.fill(child: Image.file(file, fit: BoxFit.cover)),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
              child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
