abstract class AuthRepository {
  Future verifySession(String tempToken, String aggId, String clientID, String appLanguage);
}
