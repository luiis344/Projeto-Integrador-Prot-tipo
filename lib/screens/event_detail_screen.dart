import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/SubscriptionService.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  EventDetailScreen({required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  final SubscriptionService _subscriptionService = SubscriptionService();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _submitSubscription() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final success = await _subscriptionService.subscribeToEvent(
        eventId: widget.event.id,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
      );

      setState(() => _isSubmitting = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscrição realizada com sucesso!')),
        );
        _nomeController.clear();
        _emailController.clear();
        _telefoneController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao realizar inscrição. Tente novamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.event.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(widget.event.details, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('Começo: ${widget.event.startDate}'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('Fim: ${widget.event.endDate}'),
              ],
            ),
            Divider(height: 32),

            Text('Inscreva-se no evento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Informe seu nome';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Informe seu email';
                      if (!value.contains('@')) return 'Email inválido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _telefoneController,
                    decoration: InputDecoration(labelText: 'Telefone'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Informe seu telefone';
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitSubscription,
                    child: _isSubmitting ? CircularProgressIndicator(color: Colors.white) : Text('Inscrever-se'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
