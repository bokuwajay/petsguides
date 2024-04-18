class Category {
  final String image;
  final String name;

  Category({required this.name, required this.image});
}

final categories = [
  Category(name: "Today Deals", image: "assets/pets/today_deals_category.png"),
  Category(name: "Cat Food", image: "assets/pets/cat_food_category.png"),
  Category(name: "Cat Litter", image: "assets/pets/cat_litter_category.png"),
  Category(name: "Cat Toy", image: "assets/pets/cat_toy_category.png"),
  Category(name: "Dog Food", image: "assets/pets/cat_litter_category.png"),
  Category(
      name: "Dog Supplement", image: "assets/pets/dog_supplement_category.png"),
  Category(name: "Dog Toy", image: "assets/pets/dog_toy_category.png"),
];
