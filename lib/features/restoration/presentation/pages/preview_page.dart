import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restoration_bloc.dart';
import 'processing_page.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الصورة'), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(File(imagePath), width: double.infinity, fit: BoxFit.cover),
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
                onPressed: () {
                  context.read<RestorationBloc>().add(ImagePicked(imagePath));
                  context.read<RestorationBloc>().add(const RestoreRequested());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProcessingPage()));
                },
                child: const Text('إرسال للتحسين'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
