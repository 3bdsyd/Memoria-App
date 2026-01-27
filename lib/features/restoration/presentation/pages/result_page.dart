import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restoration_bloc.dart';
import 'comparison_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestorationBloc, RestorationState>(
      listenWhen: (p, n) => p.toast != n.toast && n.toast != null,
      listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.toast!))),
      builder: (context, state) {
        final job = state.currentJob;
        if (job == null) return const Scaffold(body: Center(child: Text('لا توجد نتيجة')));

        return Scaffold(
          appBar: AppBar(
            title: const Text('النتيجة'),
            actions: [
              IconButton(
                onPressed: state.saving ? null : () => context.read<RestorationBloc>().add(const SaveEnhancedToGalleryRequested()),
                icon: state.saving ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.download),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.file(File(job.enhancedPath!), width: double.infinity, fit: BoxFit.cover),
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
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComparisonPage())),
                    child: const Text('مقارنة قبل/بعد'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
