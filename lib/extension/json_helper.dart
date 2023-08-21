part of weather_api_openweathermap;

extension DateTimeHelper on DateTime {
  static DateTime fromEpochJson(int json) =>
      DateTime.fromMicrosecondsSinceEpoch(json);

  static int toIso8601Json(DateTime date) => date.millisecondsSinceEpoch;
}

extension JsonHelper on Map<String, dynamic> {
  DateTime? asDateTime(String key) {
    if (!this.containsKey(key)) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(this[key] * 1000);
  }

  Map<String, dynamic>? asObject(String key) {
    if (!this.containsKey(key)) {
      return null;
    }

    return this[key];
  }

  Map<String, dynamic>? asListItem(String key, int index) {
    if (!this.containsKey(key)) {
      return null;
    }

    return this[key][0];
  }

  double? asDouble(String key) {
    if (!this.containsKey(key)) {
      return null;
    }

    if (this[key] is double) {
      return this[key];
    }

    if (this[key] is num) {
      return this[key].toDouble();
    }

    return double.parse(this[key]);
  }

  int? asInt(String key) {
    if (!this.containsKey(key)) {
      return null;
    }

    if (this[key] is int) {
      return this[key];
    }

    return int.parse(this[key]);
  }

  String? asString(String key) {
    if (!this.containsKey(key)) {
      return null;
    }

    return this[key].toString();
  }
}

dynamic removeNull(dynamic params) {
  if (params is Map) {
    var _map = {};
    params.forEach((key, value) {
      var _value = removeNull(value);
      if (_value != null) {
        _map[key] = _value;
      }
    });
    // comment this condition if you want empty dictionary
    if (_map.isNotEmpty)
      return _map;
  } else if (params is List) {
    var _list = [];
    for (var val in params) {
      var _value = removeNull(val);
      if (_value != null) {
        _list.add(_value);
      }
    }
    // comment this condition if you want empty list
    if (_list.isNotEmpty)
      return _list;
  } else if (params != null) {
    return params;
  }
  return null;
}