import 'package:get_it/get_it.dart';
import 'package:zatiq/src/core/configs/get_platform.dart';
import 'package:zatiq/src/core/network/api_client.dart';
import 'package:zatiq/src/features/home/data/repository/home_repository.dart';
import 'package:zatiq/src/features/home/data/source/local/home_local_service.dart';
import 'package:zatiq/src/features/home/data/source/remote/home_remote_service.dart';
import 'package:zatiq/src/features/home/domain/repository/home_repository.dart';
import 'package:zatiq/src/features/home/domain/usecase/fetch_product_list_usecase.dart';
import 'package:zatiq/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:zatiq/src/features/settings/data/models/settings_model.dart';
import 'package:zatiq/src/features/settings/data/repositories/hive_repository_impl.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/locale/locale_bloc.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/performance_overlay/bloc/performance_overlay_bloc.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/settings/bloc/settings_bloc.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/theme/bloc/theme_bloc.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/url_config/bloc/url_config_bloc.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  // app initializations
  sl.registerSingleton<PT>(PlatformInfo.getCurrentPlatformType());
  sl.registerSingleton<AppDir>(AppDir());
  sl.registerSingleton<AppSettings>(AppSettings());

  // API Client
  sl.registerSingleton<ApiClient>(ApiClient());

  // Services
  sl.registerSingleton<HomeLocalService>(HomeLocalServiceImpl());
  sl.registerSingleton<HomeRmoteService>(HomeRmoteServiceImpl(sl()));

  // Repositories
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<FetchProductListUseCase>(FetchProductListUseCase(sl()));

  // Blocs
  sl.registerFactory<LocaleBloc>(() => LocaleBloc(sl()));
  sl.registerFactory<PerformanceOverlayBloc>(() => PerformanceOverlayBloc(sl()));
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));
  sl.registerFactory<UrlConfigBloc>(() => UrlConfigBloc(sl()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
}
