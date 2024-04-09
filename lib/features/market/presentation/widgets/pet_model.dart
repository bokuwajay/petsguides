class Pet {
  final String image;
  final String name;

  Pet({required this.name, required this.image});
}

final pets = [
  Pet(name: "Bird", image: "assets/pets/bird_pet.png"),
  Pet(name: "Cat", image: "assets/pets/cat_pet.png"),
  Pet(name: "Dog", image: "assets/pets/dog_pet.png"),
  Pet(name: "Fish", image: "assets/pets/fish_pet.png"),
  Pet(name: "Rabbit", image: "assets/pets/rabbit_pet.png"),
  Pet(name: "Reptile", image: "assets/pets/reptile_pet.png"),
];
