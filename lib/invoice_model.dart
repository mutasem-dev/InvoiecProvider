import 'package:flutter/cupertino.dart';

import 'invoice.dart';

class InvoiceModel extends ChangeNotifier{
  List<Invoice> _invoices = [];
  int _selectedIndex = 0;
  void setSelectedIndex(int value) {
    _selectedIndex = value;
  }
  void refresh() {
    notifyListeners();
  }
  void setInvoices(List<Invoice> newInvoices) {
    _invoices = newInvoices;
    notifyListeners();
  }
  List<Invoice> get invoices => _invoices;
  Invoice get selectedInvoice => _invoices[_selectedIndex];
  int get length => _invoices.length;

  void add(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }
  void remove(Invoice value) {
    _invoices.remove(value);
    notifyListeners();
  }
}