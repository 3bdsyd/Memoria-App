import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restoration_bloc.dart';
import 'result_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.select((RestorationBloc b) => b.state.history);

    return Scaffold(
      appBar: AppBar(title: const Text('السجل')),
      body: history.isEmpty
          ? const Center(child: Text('لا توجد عناصر بعد'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final job = history[i];
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  tileColor: Colors.black.withOpacity(0.03),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: job.enhancedPath != null
                        ? Image.file(File(job.enhancedPath!), width: 56, height: 56, fit: BoxFit.cover)
                        : const SizedBox(width: 56, height: 56, child: Icon(Icons.image_outlined)),
                  ),
                  title: Text('ID: ${job.id}'),
                  subtitle: Text(job.createdAt.toLocal().toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => context.read<RestorationBloc>().add(DeleteJobRequested(job.id)),
                  ),
                  onTap: () {
                    context.read<RestorationBloc>().add(OpenJobRequested(job));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultPage()));
                  },
                );
              },
            ),
    );
  }
}
