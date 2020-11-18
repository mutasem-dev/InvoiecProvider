import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoices_json/invoice_model.dart';
import 'package:invoices_json/product.dart';
import 'package:provider/provider.dart';
import 'invoice.dart';
class DetailsPage extends StatelessWidget {

  int totalQuantity = 0;
  double totalPrice = 0;
  void calc(List<Product> p) {
    p.forEach((element) {
      totalQuantity += element.quantity;
      totalPrice += element.quantity*element.price;
    });
  }
  @override
  Widget build(BuildContext context) {
    calc(Provider.of<InvoiceModel>(context,listen: false).selectedInvoice.products);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<InvoiceModel>(
          builder: (context, value, child) {
            return Text(value.selectedInvoice.customerName);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<InvoiceModel>(
            builder: (context, value, child) =>
                Text('Invoice# ${value.selectedInvoice.invoiceNo}\n\nProducts:',style: TextStyle(fontSize: 25.0)),
          ),
          SizedBox(height: 15.0,),
          Container(
            height: 200.0,
            child: Consumer<InvoiceModel>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.selectedInvoice.products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                          '${index+1}- ${value.selectedInvoice.products[index].productName}, '
                              'Price: ${value.selectedInvoice.products[index].price}, '
                              'Quantity: ${value.selectedInvoice.products[index].quantity}',
                          style: TextStyle(fontSize: 18.0)),
                    );
                  },
                );
              },
            ),
          ),
          Text('Total price: $totalPrice\n'
              'Total Quantity: $totalQuantity',
              style: TextStyle(fontSize: 25.0)),
        ],
      ),
    );
  }
}
