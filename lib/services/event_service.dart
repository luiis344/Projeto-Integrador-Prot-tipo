import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventService {
  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8087/events'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Event.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}