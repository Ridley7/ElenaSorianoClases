abstract class FCMRepository{
  Future<String> saveFCMToken(String token, String id);
  Future<void> deleteFCMToken(String id);
}