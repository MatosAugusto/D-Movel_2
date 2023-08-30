class Ticket {
  final int id;
  final String title;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String contact;
  final String contactname;
  final String email;
  final String username;

  const Ticket({
    required this.id,
    required this.title,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.contact,
    required this.contactname,
    required this.email,
    required this.username,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
      hour: json['hour'],
      contact: json['contact'],
      contactname: json['contactname'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toMap(Ticket ticket) {
    final Map<String, dynamic> mapaDeTickets = {};
    mapaDeTickets[title] = ticket.title;
    mapaDeTickets[day] = ticket.day;
    mapaDeTickets[month] = ticket.month;
    mapaDeTickets[year] = ticket.year;
    mapaDeTickets[hour] = ticket.hour;
    mapaDeTickets[contact] = ticket.contact;
    mapaDeTickets[contactname] = ticket.contactname;
    mapaDeTickets[email] = ticket.email;
    mapaDeTickets[username] = ticket.username;
    return mapaDeTickets;
  }
}
