enum MeditationSound {
  none(
    id: 0,
    name: 'None',
    audioPath: null,
  ),
  ambient(
    id: 1,
    name: 'Ambient',
    audioPath: 'assets/audio/ambient.mp3',
  ),
  bell(
    id: 2,
    name: 'Bell',
    audioPath: 'assets/audio/bell.mp3',
  ),
  birds(
    id: 3,
    name: 'Birds',
    audioPath: 'assets/audio/birds.mp3',
  ),
  campfire(
    id: 4,
    name: 'Campfire',
    audioPath: 'assets/audio/campfire.mp3',
  ),
  kerriCatalpa(
    id: 5,
    name: 'Kerri Catalpa',
    audioPath: 'assets/audio/kerri_catalpa.mp3',
  ),
  meditationBowls(
    id: 6,
    name: 'Meditation Bowls',
    audioPath: 'assets/audio/meditation_bowls.mp3',
  ),
  metronome(
    id: 7,
    name: 'Metronome',
    audioPath: 'assets/audio/metronome.mp3',
  ),
  ocean(
    id: 8,
    name: 'Ocean',
    audioPath: 'assets/audio/ocean.mp3',
  ),
  padsound(
    id: 9,
    name: 'Pad Sound',
    audioPath: 'assets/audio/padsound.mp3',
  ),
  pure(
    id: 10,
    name: 'Pure',
    audioPath: 'assets/audio/pure.mp3',
  ),
  river(
    id: 11,
    name: 'River',
    audioPath: 'assets/audio/river.mp3',
  ),
  tibetanBells(
    id: 12,
    name: 'Tibetan Bells',
    audioPath: 'assets/audio/tibetan_bells.mp3',
  ),
  uplifting(
    id: 13,
    name: 'Uplifting',
    audioPath: 'assets/audio/uplifting.mp3',
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
