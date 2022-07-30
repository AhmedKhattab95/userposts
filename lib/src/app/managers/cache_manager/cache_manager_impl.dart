
import 'package:topics/src/core/core_lib.dart';

import 'cache_manager.dart';

class CacheManagerImpl implements CacheManager {
  final CacheService _cacheService;

  CacheManagerImpl(this._cacheService);

  final String _languageKey = 'languageKey';

  @override
  Future<bool> saveUserSelectedLanguage(String userLanguage) => _cacheService.saveString(_languageKey, userLanguage);

  @override
  Future<String?> getUserSelectedLanguage() => _cacheService.getString(_languageKey);

}
