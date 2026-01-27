part of 'restoration_bloc.dart';

sealed class RestorationEvent extends Equatable {
  const RestorationEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends RestorationEvent {
  const AppStarted();
}

class ImagePicked extends RestorationEvent {
  const ImagePicked(this.path);
  final String path;

  @override
  List<Object?> get props => [path];
}

class RestoreRequested extends RestorationEvent {
  const RestoreRequested();
}

class SaveEnhancedToGalleryRequested extends RestorationEvent {
  const SaveEnhancedToGalleryRequested();
}

class OpenJobRequested extends RestorationEvent {
  const OpenJobRequested(this.job);
  final RestoreJob job;

  @override
  List<Object?> get props => [job];
}

class DeleteJobRequested extends RestorationEvent {
  const DeleteJobRequested(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
