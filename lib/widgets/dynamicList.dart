
import 'package:flutter/material.dart';
import 'package:flutter_app_trials/Item.dart';

Container getListItemWidget(Item item, int index) {
  return new Container(
    color: Colors.orange,
    child: new Card(
      margin:
      new EdgeInsets.only(left: 10.0, top: 7.0, right: 10.0, bottom: 7.0),
      color: Colors.white,
      child: _getListTile(index, title: item.title, price: item.price, seller: item.seller),
      elevation: 1.1,
    ),
  );
}

Widget _getListTile(int index, { String title, String price, String seller } ) {
  assert(title != null);
  assert(seller != null);

  if (index % 2 == 0) {
    return new ListTile(
      title: _getTitleWidget(title),
      subtitle: _getPriceWidget(price),
      trailing: _getSellerWidget(seller),
      isThreeLine: true,
    );
  } else {
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          _getTitleWidget('Demo title'),
          _getPriceWidget('demo price'),
        ],
      ),
    );
  }
}


Text _getSellerWidget(String seller) {
  return new Text('$seller',
      style: new TextStyle(fontSize: 12.0, color: Colors.orange));
}

Text _getPriceWidget(String price) {
  return new Text('Price: \$${price ?? 'N/A'}',
      style: new TextStyle(fontSize: 12.0, color: Colors.orange));
}

Text _getTitleWidget(String title) {
  return new Text(title, style: new TextStyle(fontWeight: FontWeight.bold));
}
