class ModelProduct {
  ModelProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
  });

  final int id;
  final String name;
  final String category;
  final String imageUrl;
  final String oldPrice;
  final String price;

  factory ModelProduct.fromJson(Map<String, dynamic> json) {
    return ModelProduct(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      imageUrl: json["imageUrl"],
      oldPrice: json["oldPrice"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "imageUrl": imageUrl,
        "oldPrice": oldPrice,
        "price": price,
      };
}
