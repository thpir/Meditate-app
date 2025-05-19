enum MeditationSound {
  none(
    id: 0,
    name: 'None',
    audioPath: null,
  ),
  birds(
    id: 1,
    name: 'Birds',
    audioPath: 'assets/audio/birds.mp3',
  ),
  kerriCatalpa(
    id: 2,
    name: 'Kerri Catalpa',
    audioPath: 'assets/audio/kerri_catalpa.mp3',
  ),
  metronome(
    id: 3,
    name: 'Metronome',
    audioPath: 'assets/audio/metronome.mp3',
  ),
  ocean(
    id: 4,
    name: 'Ocean',
    audioPath: 'assets/audio/ocean.mp3',
  ),
  river(
    id: 5,
    name: 'River',
    audioPath: 'assets/audio/river.mp3',
  ),
  tibetanBells(
    id: 6,
    name: 'Tibetan Bells',
    audioPath: 'assets/audio/tibetan_bells.mp3',
  );

  final int id;
  final String name;
  final String? audioPath;

  const MeditationSound({
    required this.id,
    required this.name,
    required this.audioPath,
  });
}
