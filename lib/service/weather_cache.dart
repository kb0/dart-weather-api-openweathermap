interface class ICacheManager {
  Future<String?> getData(double latitude, double longitude, DateTime timestamp) async {
    return null;
  }

  Future<bool> putData(String data, double latitude, double longitude, DateTime timestamp, Duration ttl) async {
    return true;
  }
}