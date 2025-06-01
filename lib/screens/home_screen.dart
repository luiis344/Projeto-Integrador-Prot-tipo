import '../services/location_service.dart';
import 'package:flutter/material.dart';
import '../services/event_service.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';
import './perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> events = [];
  String _city = 'Localização não disponível';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      String city = await LocationService().getCityFromCoordinates();
      setState(() {
        _city = city;
      });
    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }

  Future<void> _fetchEvents() async {
    try {
      final eventService = EventService();
      final fetchedEvents = await eventService.fetchEvents();
      setState(() {
        events = fetchedEvents;
      });
    } catch (e) {
      print("Erro ao buscar eventos: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreenContent(events: events, city: _city),
      Center(child: Text('Explorar')), // Substitua conforme necessário
      Center(child: Text('Eventos')), // Substitua conforme necessário
      TelaPerfil(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final List<Event> events;
  final String city;

  HomeScreenContent({required this.events, required this.city});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BoraLá!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("Os melhores eventos próximos a você!"),
          SizedBox(height: 16),
          Text('Localização: $city'),
          SizedBox(height: 16),
          Expanded(
            child: events.isEmpty
                ? Center(child: Text("Nenhum evento disponível"))
                : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailScreen(event: events[index]),
                      ),
                    );
                  },
                  child: EventCard(event: events[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
