
import 'service_locator.dart';

abstract class Setup {
  final ServiceLocator locator = serviceLocator;

  Future<void> setup();
}
