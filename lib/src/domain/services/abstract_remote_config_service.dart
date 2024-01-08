

abstract class AbstractFirebaseRemoteConfigService {
  Future<void> initRemoteConfig();
  Future<String> getStringValue(String key);
  Future<String> getNumberValue(String key);
  Future<String> getBoolValue(String key);
}
