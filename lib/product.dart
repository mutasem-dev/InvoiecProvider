class Product {
  String productName;
  int quantity;
  double price;

  Product({this.productName, this.quantity, this.price});
  factory Product.fromJson(dynamic json) {
    return Product(
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
    );
  }

  @override
  String toString() {
    return 'Product{productName: $productName, quantity: $quantity, price: $price}';
  }
}