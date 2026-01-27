import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/app_file_store.dart';
import '../../domain/entities/restore_job.dart';
import '../../domain/repositories/restoration_repository.dart';

part 'restoration_event.dart';
part 'restoration_state.dart';

class RestorationBloc extends Bloc<RestorationEvent, RestorationState> {
  RestorationBloc({required this.repo, required this.fileStore}) : super(const RestorationState()) {
    on<AppStarted>(_onStarted);
    on<ImagePicked>(_onImagePicked);
    on<RestoreRequested>(_onRestoreRequested);
    on<SaveEnhancedToGalleryRequested>(_onSaveEnhanced);
    on<OpenJobRequested>(_onOpenJob);
    on<DeleteJobRequested>(_onDeleteJob);
  }

  final RestorationRepository repo;
  final AppFileStore fileStore;

  Future<void> _onStarted(AppStarted e, Emitter<RestorationState> emit) async {
    final history = await repo.loadHistory();
    emit(state.copyWith(history: history));
  }

  void _onImagePicked(ImagePicked e, Emitter<RestorationState> emit) {
    emit(state.copyWith(selectedImagePath: e.path, status: RestoreStatus.ready));
  }

  Future<void> _onRestoreRequested(RestoreRequested e, Emitter<RestorationState> emit) async {
    final path = state.selectedImagePath;
    if (path == null) return;

    emit(state.copyWith(status: RestoreStatus.uploading, error: null));

    try {
      final originalLocal = await repo.persistOriginal(path);

      final uploadRes = await repo.upload(path);
      final id = uploadRes.imageId;

      emit(state.copyWith(status: RestoreStatus.downloadingEnhanced, imageId: id));

      final enhancedPath = await repo.downloadEnhancedToFile(id);

      emit(state.copyWith(status: RestoreStatus.downloadingCompare));

      final comparePath = await repo.downloadCompareToFile(id);

      final job = RestoreJob(
        id: id,
        createdAt: DateTime.now(),
        originalPath: originalLocal,
        enhancedPath: enhancedPath,
        comparePath: comparePath,
        metrics: uploadRes.metrics,
      );

      await repo.saveJob(job);
      final history = await repo.loadHistory();

      emit(state.copyWith(
        status: RestoreStatus.done,
        currentJob: job,
        history: history,
      ));
    } catch (ex) {
      emit(state.copyWith(status: RestoreStatus.failure, error: 'حدث خطأ أثناء التحسين'));
    }
  }

  Future<void> _onSaveEnhanced(SaveEnhancedToGalleryRequested e, Emitter<RestorationState> emit) async {
    final job = state.currentJob;
    final enhanced = job?.enhancedPath;
    if (enhanced == null) return;

    emit(state.copyWith(saving: true));
    final result = await fileStore.saveFileToGallery(enhanced);
    emit(state.copyWith(saving: false, toast: result.message));
  }

  void _onOpenJob(OpenJobRequested e, Emitter<RestorationState> emit) {
    emit(state.copyWith(currentJob: e.job, imageId: e.job.id));
  }

  Future<void> _onDeleteJob(DeleteJobRequested e, Emitter<RestorationState> emit) async {
    await repo.deleteJob(e.id);
    final history = await repo.loadHistory();
    emit(state.copyWith(history: history));
  }
}
