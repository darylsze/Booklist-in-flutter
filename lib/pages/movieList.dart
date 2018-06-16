import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_trials/layouts/defaultLayout.dart';

class MovieListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    return getDefaultLayout(
        title: 'Movie List',
        body: new GridView.count(
            crossAxisCount: 3,
            padding: new EdgeInsets.all(7.0),
            scrollDirection: Axis.vertical,
            childAspectRatio: 9 / 16 * 1.0,
            crossAxisSpacing: 7.0,
            children: new List.generate(10, (index) {
              return new Column(
                children: <Widget>[
                  new Image(image: new AssetImage('assets/images/movie.jpg')),
                  new Column(
                    children: <Widget>[
                      new Text('movie movie', textScaleFactor: 1.2),
                      new Row(
                        children: <Widget>[
                          _getReactionItem(icon: Icons.star_border, size: 14.0, content: '2903'),
                          _getReactionItem(icon: Icons.mode_comment, size: 14.0, content: '2903'),
                          _getReactionItem(icon: Icons.add, size: 14.0, content: '2903'),
                        ],
                      )
                    ],
                  )
                ],
              );
            })));
  }

  _getReactionItem({IconData icon, double size, String content}) {
    return new Row(children: <Widget>[
      new Icon(icon, size: size),
      new Text(content, softWrap: true, textScaleFactor: 0.85)
    ]);
  }
}
