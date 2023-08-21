part of weather_api_openweathermap;

/// Plugin for fetching weather data in JSON.
class WeatherFactory {
  String _apiKey;
  String _language;
  ICacheManager? _cache;

  static const String API_BASE = 'api.openweathermap.org';

  static const String API_ROUTE_FORECAST = '/data/2.5/forecast';
  static const String API_ROUTE_CURRENT_WEATHER = '/data/2.5/weather';
  static const int STATUS_OK = 200;

  late http.Client _httpClient;

  WeatherFactory(this._apiKey, this._language, this._cache) {
    _httpClient = http.Client();
  }

  /// Fetch current weather based on geographical coordinates
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/current
  Future<WeatherData?> currentWeatherByCoordinates(double latitude,
      double longitude) async {
    try {
      var cachedJsonResponse =
      await _cache?.getData(latitude, longitude, DateTime.now());
      if (cachedJsonResponse != null) {
        return WeatherData.fromJson(jsonDecode(cachedJsonResponse));
      }
    } catch (ignored) {
      // TODO log exception
    }

    try {
      String jsonResponse = await _sendRequest(API_ROUTE_CURRENT_WEATHER,
          lat: latitude, lon: longitude);

      await _cache?.putData(
          jsonResponse, latitude, longitude, DateTime.now(),
          Duration(hours: 1));

      return WeatherData.fromJson(jsonDecode(jsonResponse));
    } catch (error) {
      return null;
    }
  }

  Future<WeatherData?> currentWeatherByCity(String cityName) async {
    Map<String, dynamic>? jsonResponse = json.decode(
        await _sendRequest(API_ROUTE_CURRENT_WEATHER, cityName: cityName));

    return jsonResponse != null ? WeatherData.fromJson(jsonResponse) : null;
  }

  Future<String> _sendRequest(String route,
      {double? lat, double? lon, String? cityName}) async {
    /// Build HTTP get url by passing the required parameters
    Uri url = _buildUri(route, cityName, lat, lon);

    /// Send HTTP get response with the url
    http.Response response = await _httpClient.get(url);

    /// Perform error checking on response:
    /// Status code 200 means everything went well
    if (response.statusCode == STATUS_OK) {
      return response.body;
    }

    /// The API key is invalid, the API may be down
    /// or some other unspecified error could occur.
    /// The concrete error should be clear from the HTTP response body.
    else {
      throw Exception("The API threw an exception: ${response.body}");
    }
  }

  Uri _buildUri(String route, String? cityName, double? lat, double? lon) {
    Map<String, String> qParams = {
      'appid': _apiKey,
      'lang': _language,
      'units': 'standard',
    };

    if (cityName != null) {
      qParams['q'] = cityName;
    }

    if (lat != null && lon != null) {
      qParams['lat'] = lat.toString();
      qParams['lon'] = lon.toString();
    }

    return Uri.https(API_BASE, route, qParams);
  }
}
