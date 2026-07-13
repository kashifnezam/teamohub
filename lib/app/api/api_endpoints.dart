class ApiEndpoints {
  static const String baseUrl =
      "https://countriesnow.space/api/v0.1";

  static const String countries =
      "$baseUrl/countries";

  static const String states =
      "$baseUrl/countries/states/q";

  static const String cities =
      "$baseUrl/countries/state/cities/q";
}