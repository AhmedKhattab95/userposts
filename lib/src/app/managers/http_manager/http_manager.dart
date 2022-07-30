
import 'package:topics/src/core/core_lib.dart';

abstract class HttpManager {
  HttpService get httpService;

  Future<void> init();
}
