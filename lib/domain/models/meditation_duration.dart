enum MeditationDuration {
  min5(
    id: 0,
    name: '5 minutes',
    duration: Duration(minutes: 5),
  ),
  min10(
    id: 1,
    name: '10 minutes',
    duration: Duration(minutes: 10),
  ),
  min15(
    id: 2,
    name: '15 minutes',
    duration: Duration(minutes: 15),
  ),
  min20(
    id: 3,
    name: '20 minutes',
    duration: Duration(minutes: 20),
  ),
  min25(
    id: 4,
    name: '25 minutes',
    duration: Duration(minutes: 25),
  ),
  min30(
    id: 5,
    name: '30 minutes',
    duration: Duration(minutes: 30),
  ),
  min35(
    id: 6,
    name: '35 minutes',
    duration: Duration(minutes: 35),
  ),
  min40(
    id: 7,
    name: '40 minutes',
    duration: Duration(minutes: 40),
  ),
  min45(
    id: 8,
    name: '45 minutes',
    duration: Duration(minutes: 45),
  ),
  min50(
    id: 9,
    name: '50 minutes',
    duration: Duration(minutes: 50),
  ),
  min55(
    id: 10,
    name: '55 minutes',
    duration: Duration(minutes: 55),
  ),
  min60(
    id: 11,
    name: '60 minutes',
    duration: Duration(minutes: 60),
  );

  final int id;
  final String name;
  final Duration duration;
  
  const MeditationDuration({
    required this.id,
    required this.name,
    required this.duration,
  });
}