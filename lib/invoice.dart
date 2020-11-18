import 'product.dart';
class Invoice  {
  int invoiceNo;
  String customerName;
  List<Product> products;

  Invoice({this.customerName, this.products,this.invoiceNo});
  factory Invoice.fromJson(dynamic jsonObject) {
    var prds = jsonObject['products'] as List;
    List<Product> _products = prds.map((element) => Product.fromJson(element)).toList();
//    List<Product> _products = [];
//    prds.forEach((element) {
//      _products.add(Product.fromJson(element));
//    });
//    for(int i=0;i<prds.length;i++)
//      _products.add(Product.fromJson(prds[i]));
    return Invoice(
      invoiceNo: jsonObject['invoiceNo'] as int,
      customerName: jsonObject['customerName'] as String,
      products: _products,
    );
  }

  @override
  String toString() {
    return 'Invoice{invoiceNo: $invoiceNo, customerName: $customerName, products: $products}';
  }
}