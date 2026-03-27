enum Avatar {
  sofie(
    id: 0,
    name: 'Sofie',
    imagePath: 'assets/images/avatar_1.webp',
  ),
  luna(
    id: 1,
    name: 'Luna',
    imagePath: 'assets/images/avatar_2.webp',
  ),
  maya(
    id: 2,
    name: 'Maya',
    imagePath: 'assets/images/avatar_3.webp',
  ),
  zara(
    id: 3,
    name: 'Zara',
    imagePath: 'assets/images/avatar_4.webp',
  ),
  leo(
    id: 4,
    name: 'Leo',
    imagePath: 'assets/images/avatar_5.webp',
  ),
  kai(
    id: 5,
    name: 'Kai',
    imagePath: 'assets/images/avatar_6.webp',
  ),
  ava(
    id: 6,
    name: 'Ava',
    imagePath: 'assets/images/avatar_7.webp',
  ),
  ezra(
    id: 7,
    name: 'Ezra',
    imagePath: 'assets/images/avatar_8.webp',
  ),
  jax(
    id: 8,
    name: 'Jax',
    imagePath: 'assets/images/avatar_9.webp',
  ),
  nova(
    id: 9,
    name: 'Nova',
    imagePath: 'assets/images/avatar_10.webp',
  ),
  milo(
    id: 10,
    name: 'Milo',
    imagePath: 'assets/images/avatar_11.webp',
  ),
  sage(
    id: 11,
    name: 'Sage',
    imagePath: 'assets/images/avatar_12.webp',
  );

  final int id;
  final String name;
  final String imagePath;

  const Avatar({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}
