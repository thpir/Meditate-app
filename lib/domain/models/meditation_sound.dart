enum MeditationSound {
  none(
    id: 0,
    name: 'None',
    audioPath: null,
  ),
  birds(
    id: 1,
    name: 'Birds',
    audioPath: 'assets/audio/birds.wav',
  ),
  kerriCatalpa(
    id: 2,
    name: 'Kerri Catalpa',
    audioPath: 'assets/audio/kerri_catalpa.wav',
  ),
  metronomeOption1(
    id: 3,
    name: 'Metronome Option 1',
    audioPath: 'assets/audio/metronome_option_1.wav',
  ),
  metronomeOption2(
    id: 4,
    name: 'Metronome Option 2',
    audioPath: 'assets/audio/metronome_option_2.wav',
  ),
  ocean(
    id: 5,
    name: 'Ocean',
    audioPath: 'assets/audio/ocean.wav',
  ),
  river(
    id: 6,
    name: 'River',
    audioPath: 'assets/audio/river.wav',
  ),
  tibetanBells(
    id: 7,
    name: 'Tibetan Bells',
    audioPath: 'assets/audio/tibetan_bells.wav',
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
