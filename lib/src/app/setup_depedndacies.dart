import 'package:topics/src/app/executer/executer.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/users_posts_data_service.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/users_posts_manager/users_posts_manager.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/users_posts_manager/users_posts_manager_impl.dart';
import 'package:topics/src/app/settings/settings_service.dart';
import 'package:topics/src/core/core_lib.dart';

import 'managers/managers_lib.dart';
import 'settings/settings_controller.dart';

class AppSetup extends Setup {
  ///region singleton
  AppSetup._();

  static AppSetup? _instance;

  static AppSetup get instance => (_instance ??= AppSetup._());

  /// endregion

  bool setuped = false;

  @override
  Future<void> setup() async {
    if (setuped) return;
    setuped = true;

    /// call core registration
    await CoreSetup.instance.setup();

    locator.registerLazySingleton<CacheManager>(CacheManagerImpl(serviceLocator<CacheService>()));

    locator.registerLazySingleton<SettingsService>(SettingsServiceImpl(serviceLocator<CacheManager>()));
    locator.registerLazySingleton<SettingsController>(
        SettingsController(serviceLocator<SettingsService>(), serviceLocator<CacheManager>()));

    locator.registerLazySingleton<HttpManager>(HttpManagerImpl(locator<HttpService>()));

    locator.registerLazySingleton<UsersPostsDataService>(UsersPostsDataServiceImpl(serviceLocator<HttpManager>()));
    locator.registerLazySingleton<Executer>(ExecuterImpl(
        connectivityService: serviceLocator<ConnectivityService>(),
        dialogService: serviceLocator<DialogService>(),
        navigationService: serviceLocator<NavigationService>()));

    locator.registerLazySingleton<UsersPostsManager>(UsersPostsManagerImpl(serviceLocator<UsersPostsDataService>()));

    await _initalizeWhichNeedsIntialize();

    ///endregion
  }

  Future<void> _initalizeWhichNeedsIntialize() async {
    var httpManager = locator<HttpManager>();
    await httpManager.init();
  }
}
