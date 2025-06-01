import 'dart:convert';
import 'package:http/http.dart' as http;

class SubscriptionService {
  Future<bool> subscribeToEvent({
    required int eventId,
    required String nome,
    required String email,
    required String telefone,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8087/subscriptions');

    final body = jsonEncode({
      "name": nome,
      "email": email,
      "phone": telefone,
      "eventId": eventId
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
