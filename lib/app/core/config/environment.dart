class Environment {
  static const bool isProduction = false;
  static const String apiUrl = isProduction
      ? "https://api.ledgerface.com/api/"
      : "http://192.168.1.6:8000/api/";
}
