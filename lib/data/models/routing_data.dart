class RoutingData {
  final String route;
  final Map<String, String> queryParameters;

  RoutingData({required this.route, required this.queryParameters});

  String? operator [](String key) => queryParameters[key];
}
