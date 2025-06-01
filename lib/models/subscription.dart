class Subscription {
  final String name;
  final String email;
  final String phone;
  final int eventId;

  Subscription({
    required this.name,
    required this.email,
    required this.phone,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'eventId': eventId,
    };
  }
}
