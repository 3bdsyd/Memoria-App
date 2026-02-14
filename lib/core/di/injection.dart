import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_factory.dart';
import '../storage/app_file_store.dart';
import '../storage/history_store.dart';

import '../../features/restoration/data/datasources/restoration_remote_data_source.dart';
import '../../features/restoration/data/repositories/restoration_repository_impl.dart';
import '../../features/restoration/domain/repositories/restoration_repository.dart';
import '../../features/restoration/presentation/bloc/restoration_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final historyStore = HistoryStore();
  await historyStore.init();

  getIt.registerSingleton<HistoryStore>(historyStore);
  getIt.registerLazySingleton<AppFileStore>(() => AppFileStore());
  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  getIt.registerLazySingleton<RestorationRemoteDataSource>(
    () => RestorationRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<RestorationRepository>(
    () => RestorationRepositoryImpl(
      remote: getIt<RestorationRemoteDataSource>(),
      historyStore: getIt<HistoryStore>(),
    ),
  );

  getIt.registerLazySingleton<RestorationBloc>(
    () => RestorationBloc(
      repo: getIt<RestorationRepository>(),
      fileStore: getIt<AppFileStore>(),
    )..add(const AppStarted()),
  );
}
