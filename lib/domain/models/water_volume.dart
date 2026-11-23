/// Preset amounts a user can add to (or remove from) today's water intake.
enum WaterVolume {
  ml50(id: 0, label: '50 ml', ml: 50),
  ml100(id: 1, label: '100 ml', ml: 100),
  ml200(id: 2, label: '200 ml', ml: 200),
  ml300(id: 3, label: '300 ml', ml: 300),
  ml500(id: 4, label: '500 ml', ml: 500);

  final int id;
  final String label;
  final int ml;

  const WaterVolume({required this.id, required this.label, required this.ml});

  static const WaterVolume defaultVolume = WaterVolume.ml200;

  /// Looks up a volume by its amount in ml, falling back to [defaultVolume]
  /// (e.g. when nothing was stored yet and shared prefs returns 0).
  static WaterVolume fromMl(int ml) => WaterVolume.values.firstWhere(
    (volume) => volume.ml == ml,
    orElse: () => defaultVolume,
  );
}
