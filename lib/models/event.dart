class Event {
  final int id;
  final String name;
  final String details;
  final String startDate;
  final String endDate;

  Event({
    required this.id,
    required this.name,
    required this.details,
    required this.startDate,
    required this.endDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      details: json['detail'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}
