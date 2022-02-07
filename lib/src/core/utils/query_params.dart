Map<String, String> createUriParams(Map<String, dynamic> map) =>
    map.map((key, value) => MapEntry(key, value.toString()));
