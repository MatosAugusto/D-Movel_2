class Event {
  final int id;
  final String title;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String local;
  final String description;
  final String contact;
  final String contactname;

  const Event({
    required this.id,
    required this.title,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.local,
    required this.description,
    required this.contact,
    required this.contactname,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
      hour: json['hour'],
      local: json['local'],
      description: json['description'],
      contact: json['contact'],
      contactname: json['contactname'],
    );
  }

  Map<String, dynamic> toMap(Event event) {
    final Map<String, dynamic> mapaDeEventos = {};
    mapaDeEventos[title] = event.title;
    mapaDeEventos[day] = event.day;
    mapaDeEventos[month] = event.month;
    mapaDeEventos[year] = event.year;
    mapaDeEventos[hour] = event.hour;
    mapaDeEventos[local] = event.local;
    mapaDeEventos[description] = event.description;
    mapaDeEventos[contact] = event.contact;
    mapaDeEventos[contactname] = event.contactname;
    return mapaDeEventos;
  }
}
