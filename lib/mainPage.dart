import 'package:flutter/material.dart';
import 'package:invoices_json/invoice_model.dart';
import 'package:provider/provider.dart';
import 'customersPage.dart';
import 'invoice.dart';
import 'product.dart';
import 'package:toast/toast.dart';
import 'ProductListItem.dart';
import 'dart:convert';

class MainPage extends StatelessWidget {

  final TextEditingController controller = TextEditingController();

  List<Product> products = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Consumer<InvoiceModel>(
            builder: (context, value, child) {
              if (value.length != 0)
                return Text('Invoice# ${value.invoices.last.invoiceNo + 1}');
              else
                return Text('Invoice# 1');
            },
          )
      ),
      body: Column(
        children: [
        TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Customer Name',
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Products:', style: TextStyle(fontSize: 25.0),),
          RaisedButton(
            child: Text('add product'),
            onPressed: () {
              _showDialog(context);
            },
          ),
        ],
      ),
      Consumer<InvoiceModel>(
        builder: (context, value, child) {
          return Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: products[index],
                  deleteProduct: () {
                    products.removeAt(index);
                    value.refresh();
                  },
                );
              },
            ),
          );
        },
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
      RaisedButton(
      child: Text('add invoice'),
      onPressed: () {
        if (controller.text.isEmpty) {
          Toast.show(
              'enter customer name', context, duration: Toast.LENGTH_LONG);
          return;
        }
        if (products.isEmpty) {
          Toast.show('enter at least one product', context,
              duration: Toast.LENGTH_LONG);
          return;
        }
        int invNo = 1;
        var value = context.watch<InvoiceModel>();
        if (value.length != 0)
          invNo = value.invoices.last.invoiceNo + 1;
        value.add(
            Invoice(
              invoiceNo: invNo,
              customerName: controller.text,
              products: products,
            )
        );

        controller.clear();
        products = [];
      },
    ),
    RaisedButton(
      child: Text('show all invoices'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomersPage(),));
      },
    )
    ,
    ],
    )
    ],
    ),
    );
    }

  void _showDialog(BuildContext context) {
    List<TextEditingController> controls = [];
    for (int i = 0; i < 3; i++)
      controls.add(TextEditingController());
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Product info'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controls[0],
                  decoration: InputDecoration(
                      hintText: 'product name'
                  ),
                ),
                TextField(
                  controller: controls[1],
                  decoration: InputDecoration(
                      hintText: 'Quantity'
                  ),
                ),
                TextField(
                  controller: controls[2],
                  decoration: InputDecoration(
                      hintText: 'Price'
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Consumer<InvoiceModel>(
              builder: (context, value, child) {
                return RaisedButton(
                  child: Text('add'),
                  onPressed: () {
                    products.add(
                        Product(
                          productName: controls[0].text,
                          quantity: int.parse(controls[1].text),
                          price: double.parse(controls[2].text),
                        )
                    );
                    value.refresh();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            RaisedButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      context: context,
    );
  }


}
