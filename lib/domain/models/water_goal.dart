/// Daily water intake goals the user can pick in the user settings
/// (1.00 L to 4.00 L in steps of 0.25 L).
enum WaterGoal {
  ml1000(id: 0, name: '1.00 L', ml: 1000),
  ml1250(id: 1, name: '1.25 L', ml: 1250),
  ml1500(id: 2, name: '1.50 L', ml: 1500),
  ml1750(id: 3, name: '1.75 L', ml: 1750),
  ml2000(id: 4, name: '2.00 L', ml: 2000),
  ml2250(id: 5, name: '2.25 L', ml: 2250),
  ml2500(id: 6, name: '2.50 L', ml: 2500),
  ml2750(id: 7, name: '2.75 L', ml: 2750),
  ml3000(id: 8, name: '3.00 L', ml: 3000),
  ml3250(id: 9, name: '3.25 L', ml: 3250),
  ml3500(id: 10, name: '3.50 L', ml: 3500),
  ml3750(id: 11, name: '3.75 L', ml: 3750),
  ml4000(id: 12, name: '4.00 L', ml: 4000);

  final int id;
  final String name;
  final int ml;

  const WaterGoal({required this.id, required this.name, required this.ml});

  static const WaterGoal defaultGoal = WaterGoal.ml2000;

  /// Looks up a goal by its amount in ml, falling back to [defaultGoal]
  /// (e.g. when nothing was stored yet and shared prefs returns 0).
  static WaterGoal fromMl(int ml) => WaterGoal.values.firstWhere(
    (goal) => goal.ml == ml,
    orElse: () => defaultGoal,
  );
}
