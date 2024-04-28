import 'dart:convert';
import 'package:http/http.dart' as http;

class AGiXTSDK {
  final String baseUri;
  final String? apiKey;

  AGiXTSDK({
    this.baseUri = "http://localhost:7437",
    this.apiKey,
  });

  Future<List<String>> getProviders() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUri/api/provider"),
        headers: _getHeaders(),
      );
      final data = jsonDecode(response.body);
      return List<String>.from(data["providers"]);
    } catch (e) {
      return handleError(e.toString());
    }
  }

  Future<List<String>> handleError(String error) async {
    print("Error: $error");
    return ["Unable to retrieve data."];
  }

  Map<String, String> _getHeaders() {
    final headers = {"Content-Type": "application/json"};
    if (apiKey != null) {
      headers["Authorization"] = "Bearer $apiKey";
    }
    return headers;
  }
}