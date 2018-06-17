import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_trials/exceptions.dart';
import 'package:flutter_app_trials/layouts/defaultLayout.dart';

enum LayoutType { GRID, LIST, POSTER }

enum LayoutDefKeys {
  ICON, NEXT_TYPE
}

class BookListPage extends StatefulWidget {
  final layout = LayoutType.GRID;

  @override
  State<StatefulWidget> createState() {
    return new _BookListState();
  }
}

class _BookListState extends State<BookListPage> {
  LayoutType _layoutType = LayoutType.GRID;

  Map<LayoutType, dynamic> _layoutDefinition = {
    LayoutType.GRID: {
      LayoutDefKeys.ICON: Icons.list,
      LayoutDefKeys.NEXT_TYPE: LayoutType.LIST
    },
    LayoutType.LIST: {
      LayoutDefKeys.ICON: Icons.crop_square,
      LayoutDefKeys.NEXT_TYPE: LayoutType.POSTER
    },
    LayoutType.POSTER: {
      LayoutDefKeys.ICON: Icons.grid_on,
      LayoutDefKeys.NEXT_TYPE: LayoutType.GRID
    }
  };

  @override
  Widget build(BuildContext context) {
    return getDefaultLayout(
        title: 'Book List',
        body: _getMovieListBody(_layoutType),
        actions: [_getMovieListTypeAction()]);
  }

  _getReactionItem({IconData icon, double size, String content}) {
    return new Row(
      children: <Widget>[
        new Icon(icon, size: size),
        new Text(content,
            softWrap: true, textScaleFactor: 0.85, textAlign: TextAlign.center)
      ]
    );
  }

  _getMovieListBody(LayoutType layoutType) {
    print('getting movie list body with type $layoutType');
    switch (layoutType) {
      case LayoutType.GRID:
        return _getGridViewList();
      case LayoutType.LIST:
        return _getVerticalViewList();
      case LayoutType.POSTER:
        return _getPosterViewList();
      default:
        throw new NotImplementedException(message: 'Not implemented');
    }
  }

  Widget _getVerticalViewList() {
    var items = new List.generate(10, (index) => index);
    return new ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return _verticalListItemWidget(items[index], index);
        });
  }

  Widget _getGridViewList() {
    return new GridView.count(
        crossAxisCount: 3,
        padding: new EdgeInsets.all(7.0),
        scrollDirection: Axis.vertical,
        childAspectRatio: 9 / 18.5 * 1.0,
        crossAxisSpacing: 7.0,
        children: new List.generate(10, (index) {
          return new Column(
            children: <Widget>[
              new Image(image: new AssetImage('assets/images/book.jpg')),
              new Padding(padding: new EdgeInsets.only(top: 5.0, bottom: 5.0)),
              new Column(
                children: <Widget>[
                  new Text('Rich dad poor dad', textScaleFactor: 1.2, textAlign: TextAlign.center),
                  new Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      _getReactionItem(
                          icon: Icons.star_border, size: 13.0, content: '3012'),
                      _getReactionItem(
                          icon: Icons.mode_comment,
                          size: 13.0,
                          content: '23'),
                      _getReactionItem(
                          icon: Icons.add, size: 13.0, content: '10'),
                    ],
                  )
                ],
              )
            ],
          );
        }));
  }

  _showViewType(LayoutType toViewType) {
    setState(() {
      _layoutType = toViewType;
    });
  }

  IconButton _getMovieListTypeAction() {
    return new IconButton(
        icon: new Icon(_layoutDefinition[_layoutType][LayoutDefKeys.ICON]),
        onPressed: () {
          print('action icon clicked');
          print(
              'show change to type: ${_layoutDefinition[_layoutType][LayoutDefKeys.NEXT_TYPE]}');
          _showViewType(_layoutDefinition[_layoutType][LayoutDefKeys.NEXT_TYPE]);
        });
  }

  Widget _getPosterViewList() {
    return const Text('hi in poster view list');
  }

  Widget _verticalListItemWidget(int item, int index) {
    return new Container(
      child: new ListTile(
        leading: const Image(image: AssetImage('assets/images/movie.jpg')),
        title: const Text('movie movie'),
        subtitle: new Row(
          children: <Widget>[
            _getReactionItem(
                icon: Icons.star_border, size: 13.0, content: '2903'),
            _getReactionItem(
                icon: Icons.mode_comment,
                size: 13.0,
                content: '2903'),
            _getReactionItem(
                icon: Icons.add, size: 13.0, content: '2903'),
          ],
        ),
      ),
    );
  }
}
