import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../widgets/event_card_grid.dart';
import 'event_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final eventService = EventService();
      final fetchedEvents = await eventService.fetchEvents();
      setState(() {
        events = fetchedEvents;
      });
    } catch (e) {
      print('Erro ao buscar eventos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explorar eventos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Expanded(
            child: events.isEmpty
                ? Center(child: Text('Nenhum evento disponível'))
                : GridView.builder(
              itemCount: events.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                  child: EventGridCard(event: event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
