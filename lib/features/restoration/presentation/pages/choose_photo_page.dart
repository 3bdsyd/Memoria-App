import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'preview_page.dart';

class ChoosePhotoPage extends StatelessWidget {
  const ChoosePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر صورة'), backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFBFC5FF), Colors.white]),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('اجعل ذكرياتك أوضح', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset('assets/images/choose_preview.jpg', height: 220, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            const Text('كيف يعمل التطبيق؟', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('1) اختر صورة\n2) ارفعها للخادم\n3) استلم النسخة المحسّنة\n4) قارن ثم حمّل'),
            const SizedBox(height: 16),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  final picker = ImagePicker();
                  final img = await picker.pickImage(source: ImageSource.gallery, imageQuality: 95);
                  if (img == null) return;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewPage(imagePath: img.path)));
                },
                child: const Text('اختيار صورة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
