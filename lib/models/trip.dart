class Trip {
  final String id;
  final String title;
  final String from;
  final String to;
  final String departure;
  final int durationMinutes;
  final String stop;
  final String type;
  final double price;
  final int rating;
  final String description;

  const Trip({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.departure,
    required this.durationMinutes,
    required this.stop,
    required this.type,
    required this.price,
    required this.rating,
    required this.description,
  });
}
