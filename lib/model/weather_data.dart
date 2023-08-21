part of weather_api_openweathermap;

class WeatherData {
  // coord.lat Latitude of the location
  final double latitude;

  // coord.lon Longitude of the location
  final double longitude;

  // sys.sunrise
  final DateTime? sunrise;

  // sys.sunset
  final DateTime? sunset;

  // sys.country
  final String? countryCode;

  // dt, timezone
  final DateTime datetime;

  // weather.id Weather condition id
  final int id;

  // weather.icon Weather icon id
  final String code;

  // weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
  final String type;

  // weather.description Weather condition within the group. You can get the output in your language. Learn more
  final String description;

  // main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double temperature;

  // Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double? temperatureMin;

  // Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double? temperatureMax;

  // main.feels_like Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double? temperatureFeelsLike;

  // main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
  final double? pressure;

  //main.sea_level Atmospheric pressure on the sea level, hPa
  //main.grnd_level Atmospheric pressure on the ground level, hPa

  // main.humidity Humidity, %
  final double? humidity;

  // visibility Visibility, meter. The maximum value of the visibility is 10km
  final double? visibility;

  // clouds.all Cloudiness, %
  final double? cloudiness;

  // wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
  final double? windSpeed;

  // wind.gust Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
  final double? windSpeedGust;

  // wind.deg Wind direction, degrees (meteorological)
  final double? windDirection;

  // rain.1h (where available) Rain volume for the last 1 hour, mm. Please note that only mm as units of measurement are available for this parameter.
  final double? precipitationRain1H;

  // rain.3h (where available) Rain volume for the last 3 hours, mm. PPlease note that only mm as units of measurement are available for this parameter.
  final double? precipitationRain3H;

  // snow.1h (where available) Snow volume for the last 1 hour, mm. Please note that only mm as units of measurement are available for this parameter.
  final double? precipitationSnow1H;

  // snow.3h (where available)Snow volume for the last 3 hours, mm. Please note that only mm as units of measurement are available for this parameter.
  final double? precipitationSnow3H;

  WeatherData(
      {required this.latitude,
      required this.longitude,
      this.sunrise,
      this.sunset,
      this.countryCode,
      required this.datetime,
      required this.id,
      required this.code,
      required this.type,
      required this.description,
      required this.temperature,
      this.temperatureMin,
      this.temperatureMax,
      this.temperatureFeelsLike,
      this.pressure,
      this.humidity,
      this.visibility,
      this.cloudiness,
      this.windSpeed,
      this.windSpeedGust,
      this.windDirection,
      this.precipitationRain1H,
      this.precipitationRain3H,
      this.precipitationSnow1H,
      this.precipitationSnow3H});

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
      latitude: json.asObject('coord')!.asDouble('lat')!,
      longitude: json.asObject('coord')!.asDouble('lon')!,
      sunrise: json.asObject('sys')?.asDateTime('sunrise'),
      sunset: json.asObject('sys')?.asDateTime('sunset'),
      countryCode: json.asObject('sys')?.asString('country'),
      datetime: json.asDateTime('dt')!,

      id: json.asListItem('weather', 0)!.asInt('id')!,
      code: json.asListItem('weather', 0)!.asString('icon')!,
      type: json.asListItem('weather', 0)!.asString('main')!,
      description: json.asListItem('weather', 0)!.asString('description')!,

      temperature: json.asObject('main')!.asDouble('temp')!,
      temperatureMin: json.asObject('main')!.asDouble('temp_min'),
      temperatureMax: json.asObject('main')!.asDouble('temp_max'),
      temperatureFeelsLike: json.asObject('main')!.asDouble('feels_like'),
      pressure: json.asObject('main')!.asDouble('pressure'),
      humidity: json.asObject('main')!.asDouble('humidity'),
      visibility: json.asDouble('visibility'),
      cloudiness: json.asObject('clouds')?.asDouble('all'),
      windSpeed: json.asObject('wind')?.asDouble('speed'),
      windSpeedGust: json.asObject('wind')?.asDouble('gust'),
      windDirection: json.asObject('wind')?.asDouble('deg'),
      precipitationRain1H: json.asObject('rain')?.asDouble('1h'),
      precipitationRain3H: json.asObject('rain')?.asDouble('3h'),
      precipitationSnow1H: json.asObject('show')?.asDouble('1h'),
      precipitationSnow3H: json.asObject('show')?.asDouble('3h'));

  Map<String, dynamic> toJson() => {
        'coord': {
          'lon': longitude,
          'lat': latitude,
        },
        'sys': {
          'country': countryCode,
          'sunrise': sunrise?.millisecondsSinceEpoch,
          'sunset': sunset?.millisecondsSinceEpoch
        },
        'dt': datetime.millisecondsSinceEpoch,
        'weather': [
          {'id': id, 'icon': code, 'main': type, 'description': description}
        ],
        'main': {
          "temp": temperature,
          "feels_like": temperatureFeelsLike,
          "temp_min": temperatureMin,
          "temp_max": temperatureMax,
          "pressure": pressure,
          //"sea_level": 1015,
          //"grnd_level": 933,
          "humidity": humidity,
          //"temp_kf": -1.11
        },
        'visibility': visibility,
        'clouds': {'all': cloudiness},
        'wind': {
          'speed': windSpeed,
          'gust': windSpeedGust,
          'deg': windDirection,
        },
        'rain': {
          '1h': precipitationRain1H,
          '3h': precipitationRain3H,
        },
        'snow': {
          '1h': precipitationSnow1H,
          '3h': precipitationSnow3H,
        },
      };
}
