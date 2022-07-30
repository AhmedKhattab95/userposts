
abstract class CacheManager {

  Future<bool> saveUserSelectedLanguage(String language);

  Future<String?> getUserSelectedLanguage();

}
