import 'package:flutter/material.dart';
import 'package:flutter_app_trials/Item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.,
          primaryColor: Colors.white),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list), onPressed: _showListSelection),
          new IconButton(
              icon: new Icon(Icons.view_list), onPressed: _showSimpleList)
        ],
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have sure the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showListSelection() {
    showDialog(
        context: context,
        barrierDismissible: true,
        child: new SimpleDialog(
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('Show simple list'),
              onPressed: () {
                print('pressed simple list');
                _showSimpleList();
              },
            ),
            new SimpleDialogOption(
                child: new Text('Show dynamic item list'),
                onPressed: () {
                  print('pressed dynamic item list');
                  _showDynamicList();
                })
          ],
        )); //    Navigator.of(context).push;
  }

  void _showSimpleList() {
    Route route = new MaterialPageRoute(builder: (context) {
      final items = ['1', '2', '3', '4'];

      final _listItems = items.map((item) {
        return new ListTile(title: new Text(item));
      });

      final divided =
          ListTile.divideTiles(tiles: _listItems, context: context).toList();

      return new Scaffold(
          appBar: new AppBar(
            title: new Text('List page'),
          ),
          body: new ListView(children: divided));
    });

    routeMe(route);
  }

  void _showDynamicList() {
    Route route = new MaterialPageRoute(builder: (context) {
      final data = [
        {
          "title": 'Lenovo TAB 8704X 白色 4G版本',
          "price": '1800',
          "seller": 'ckmsamson'
        },
        {
          "title": 'Lenovo TAB 8704X 白色 4G版本',
          "price": '1800',
          "seller": 'ckmsamson'
        },
        {
          "title": '99.9 % New Sony XPERIA XA2 Ultra 黑色全套有單行貨 【等待確認】',
          "price": null,
          "seller": 'ckmsamson'
        }
      ];

      final items = data.map((item) {
        return new Item(
            title: item['title'], price: item['price'], seller: item['seller']);
      });

      return new Scaffold(
          appBar: new AppBar(
            title: new Text('List page'),
          ),
          body: new ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _getListItemWidget(items.elementAt(index), index);
              }));
    });

    routeMe(route);
  }

  void routeMe(Route route) {
    Navigator.of(context).push(route);
  }

  Container _getListItemWidget(Item item, int index) {
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
          subtitle: _getPriceWidget(price: price),
        trailing: _getSellerWidget(seller),
        isThreeLine: true,
      );
    } else {
      return new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            _getTitleWidget('Demo title'),
            _getPriceWidget(price: 'demo price'),
          ],
        ),
      );
    }
  }


  Text _getSellerWidget(String seller) {
    return new Text('$seller',
        style: new TextStyle(fontSize: 12.0, color: Colors.orange));
  }

  Text _getPriceWidget({ String price }) {
    return new Text('Price: \$${price??'N/A'}',
        style: new TextStyle(fontSize: 12.0, color: Colors.orange));
  }

  Text _getTitleWidget(String title) {
    return new Text(title, style: new TextStyle(fontWeight: FontWeight.bold));
  }

}
