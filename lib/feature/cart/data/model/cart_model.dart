class CartModel {
  num? id;
  String? title;
  String? price;
  String? quantity;
   String? category;
  String? image;

  CartModel(
      {this.id,
        this.title,
        this.price,
        this.quantity,
         this.category,
        this.image,
        });


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
     category = json['category'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
     data['category'] = category;
    data['quantity'] = quantity;
    data['image'] = image;
    return data;
  }
}
