import 'package:flutter/material.dart';
import 'product.dart';
class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback deleteProduct;


  ProductListItem({this.product, this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[200],
      child: ListTile(
        leading: Text(product.productName,
          style: TextStyle(fontSize: 25.0),),
        title: Text('Price: ${product.price}'),
        subtitle: Text('Quantity: ${product.quantity}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: deleteProduct,
        ),
      ),
    );;
  }
}
