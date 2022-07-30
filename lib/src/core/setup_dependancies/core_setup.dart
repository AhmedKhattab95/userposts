import 'package:topics/src/core/core_lib.dart';


/// should call this calss befrore start of app
class CoreSetup extends Setup {
  CoreSetup._();

  static CoreSetup? _instance;

  static CoreSetup get instance => (_instance ??= CoreSetup._());

  @override
  Future<void> setup() async {
    ///region register services
    locator.registerSingleton<HttpService>(HttpServiceImpl());
    locator.registerSingleton<CacheService>(CacheSreviceImpl());
    locator.registerSingleton<NavigationService>(NavigationServiceImpl());
    locator.registerLazySingleton<ConnectivityService>(ConnectivityServiceImpl());

    /// UI services
    locator.registerSingleton<DialogService>(DialogServiceImpl());

    ///endregion

    ///region======= register managers
    ///endregion
  }
}
