import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:weather_api_openweathermap/weather_api_openweathermap.dart';

void main() {
  test('weather data json serialization/deserialization', () async {
    var wf = WeatherFactory("API", "ru", null);
    var qq = await wf.currentWeatherByCity("Moscow");

    print(jsonEncode(qq));
  });

  test('weather data json serialization/deserialization', () async {
    final file = new File('test/resources/openweathermap_weather.json');

    var data = WeatherData.fromJson(jsonDecode(await file.readAsString()));
    expect(data.latitude, equals(44.34));
    expect(data.longitude, equals(10.99));

    expect(data.countryCode, equals("IT"));

    expect(data.datetime.toIso8601String(), equals("2022-08-30T17:43:12.000"));
    expect(data.sunrise!.toIso8601String(), equals("2022-08-30T07:36:27.000"));
    expect(data.sunset!.toIso8601String(), equals("2022-08-30T20:57:28.000"));

    expect(data.id, equals(501));
    expect(data.code, equals("10d"));
    expect(data.type, equals("Rain"));
    expect(data.description, equals("moderate rain"));

    expect(data.temperature, equals(298.48));
    expect(data.temperatureFeelsLike, equals(298.74));
    expect(data.temperatureMin, equals(297.56));
    expect(data.temperatureMax, equals(300.05));

    expect(data.pressure, equals(1015.0));
    expect(data.humidity, equals(64.0));

    expect(data.visibility, equals(10000.0));
    expect(data.cloudiness, equals(100.0));

    expect(data.windSpeed, equals(0.62));
    expect(data.windSpeedGust, equals(1.18));
    expect(data.windDirection, equals(349.0));

    expect(data.precipitationRain1H, equals(3.16));
    expect(data.precipitationRain3H, isNull);
    expect(data.precipitationSnow1H, isNull);
    expect(data.precipitationSnow3H, isNull);

    //"rain":{"1h":3.16}}
  });
}
