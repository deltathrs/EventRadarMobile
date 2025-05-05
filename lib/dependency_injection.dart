import 'package:event_radar2/feature/authentication/presentation/cubits/cubit/auth_cubit.dart';
import 'package:event_radar2/feature/authentication/repository/auth_repository.dart';
import 'package:event_radar2/feature/home/presentation/cubits/ad_slider/ad_slider_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/event_detail/event_detail_cubit.dart';
import 'package:event_radar2/feature/home/presentation/cubits/events/events_cubit.dart';
import 'package:event_radar2/feature/home/repository/adslider_repository.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  DependencyInjection._();

  static final DependencyInjection instance = DependencyInjection._();

  static DependencyInjection get getInstance => instance;

  final getIt = GetIt.instance;

  void setupDI() {
    //Register Secure Storage Service
    getIt.registerLazySingleton<SecureStorageService>(
        () => SecureStorageService());

    //Register API Service
    getIt.registerLazySingleton<ApiService>(
        () => ApiService(secureStorageService: getIt<SecureStorageService>()));

    //Register Repository
    getIt.registerLazySingleton<EventRepository>(() => EventRepository(
        secureStorageService: getIt<SecureStorageService>(),
        apiService: getIt<ApiService>()));
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(
        apiService: getIt<ApiService>(),
        secureStorageService: getIt<SecureStorageService>()));
    getIt.registerLazySingleton<AdsliderRepository>(
        () => AdsliderRepository(apiService: getIt<ApiService>()));

    //Register Cubit
    getIt.registerFactory<EventsCubit>(
        () => EventsCubit(eventRepository: getIt<EventRepository>()));
    getIt.registerFactory<AuthCubit>(
        () => AuthCubit(authRepository: getIt<AuthRepository>()));
    getIt.registerFactory<EventDetailCubit>(
        () => EventDetailCubit(eventRepository: getIt<EventRepository>()));
    getIt.registerFactory<AdSliderCubit>(
        () => AdSliderCubit(adsliderRepository: getIt<AdsliderRepository>()));
  }
}
