part of 'restoration_bloc.dart';

enum RestoreStatus { idle, ready, uploading, downloadingEnhanced, downloadingCompare, done, failure }

class RestorationState extends Equatable {
  const RestorationState({
    this.status = RestoreStatus.idle,
    this.selectedImagePath,
    this.imageId,
    this.currentJob,
    this.history = const [],
    this.error,
    this.toast,
    this.saving = false,
  });

  final RestoreStatus status;
  final String? selectedImagePath;
  final String? imageId;
  final RestoreJob? currentJob;
  final List<RestoreJob> history;
  final String? error;
  final String? toast;
  final bool saving;

  RestorationState copyWith({
    RestoreStatus? status,
    String? selectedImagePath,
    String? imageId,
    RestoreJob? currentJob,
    List<RestoreJob>? history,
    String? error,
    String? toast,
    bool? saving,
  }) {
    return RestorationState(
      status: status ?? this.status,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      imageId: imageId ?? this.imageId,
      currentJob: currentJob ?? this.currentJob,
      history: history ?? this.history,
      error: error,
      toast: toast,
      saving: saving ?? this.saving,
    );
  }

  @override
  List<Object?> get props => [status, selectedImagePath, imageId, currentJob, history, error, toast, saving];
}
