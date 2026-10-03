class Trip {
  final String id;
  final String title;
  final String route;
  final int durationMinutes;
  final String stop;
  final String type;

  const Trip({
    required this.id,
    required this.title,
    required this.route,
    required this.durationMinutes,
    required this.stop,
    required this.type,
  });
}
