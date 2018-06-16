
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_trials/Item.dart';
import 'package:flutter_app_trials/widgets/DynamicList.dart';
import 'package:flutter_app_trials/pages/home.dart';

class MyHomePageState extends State<MyHomePage> {

  MyHomePageState(this.title);

  final String title;

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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list), onPressed: _showListSelection),
          new IconButton(
              icon: new Icon(Icons.view_list), onPressed: _showSimpleList)
        ],
      ),
      body: new Center(
        child: new Column(mainAxisAlignment: MainAxisAlignment.center,
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
                return getListItemWidget(items.elementAt(index), index);
              }));
    });

    routeMe(route);
  }

  void routeMe(Route route) {
    Navigator.of(context).push(route);
  }

}
