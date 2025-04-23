enum Avatar {
  sofie(
    id: 1,
    name: 'Sofie',
    imagePath: 'assets/images/avatar_1.webp',
  ),
  luna(
    id: 2,
    name: 'Luna',
    imagePath: 'assets/images/avatar_2.webp',
  ),
  maya(
    id: 3,
    name: 'Maya',
    imagePath: 'assets/images/avatar_3.webp',
  ),
  zara(
    id: 4,
    name: 'Zara',
    imagePath: 'assets/images/avatar_4.webp',
  ),
  leo(
    id: 5,
    name: 'Leo',
    imagePath: 'assets/images/avatar_5.webp',
  ),
  kai(
    id: 6,
    name: 'Kai',
    imagePath: 'assets/images/avatar_6.webp',
  ),
  ava(
    id: 7,
    name: 'Ava',
    imagePath: 'assets/images/avatar_7.webp',
  ),
  ezra(
    id: 8,
    name: 'Ezra',
    imagePath: 'assets/images/avatar_8.webp',
  ),
  jax(
    id: 9,
    name: 'Jax',
    imagePath: 'assets/images/avatar_9.webp',
  ),
  nova(
    id: 10,
    name: 'Nova',
    imagePath: 'assets/images/avatar_10.webp',
  ),
  milo(
    id: 11,
    name: 'Milo',
    imagePath: 'assets/images/avatar_11.webp',
  ),
  sage(
    id: 12,
    name: 'Sage',
    imagePath: 'assets/images/avatar_12.webp',
  ),
  ivy(
    id: 13,
    name: 'Ivy',
    imagePath: 'assets/images/avatar_13.webp',
  ),
  orion(
    id: 14,
    name: 'Orion',
    imagePath: 'assets/images/avatar_14.webp',
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
