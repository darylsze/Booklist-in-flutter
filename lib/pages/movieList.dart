import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_trials/exceptions.dart';
import 'package:flutter_app_trials/layouts/defaultLayout.dart';

enum LAYOUT_TYPE { GRID, LIST, POSTER }

enum layoutDefinitionKeys {
  ICON, NEXT_TYPE
}

class MovieListPage extends StatefulWidget {
  var layout = LAYOUT_TYPE.GRID;

  @override
  State<StatefulWidget> createState() {
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieListPage> {
  LAYOUT_TYPE _layoutType = LAYOUT_TYPE.GRID;

  Map<LAYOUT_TYPE, dynamic> _layoutDefinition = {
    LAYOUT_TYPE.GRID: {
      layoutDefinitionKeys.ICON: Icons.list,
      layoutDefinitionKeys.NEXT_TYPE: LAYOUT_TYPE.LIST
    },
    LAYOUT_TYPE.LIST: {
      layoutDefinitionKeys.ICON: Icons.crop_square,
      layoutDefinitionKeys.NEXT_TYPE: LAYOUT_TYPE.POSTER
    },
    LAYOUT_TYPE.POSTER: {
      layoutDefinitionKeys.ICON: Icons.grid_on,
      layoutDefinitionKeys.NEXT_TYPE: LAYOUT_TYPE.GRID
    }
  };

  @override
  Widget build(BuildContext context) {
    return getDefaultLayout(
        title: 'Movie List',
        body: _getMovieListBody(_layoutType),
        actions: [_getMovieListTypeAction()]);
  }

  _getReactionItem({IconData icon, double size, String content}) {
    return new Row(children: <Widget>[
      new Icon(icon, size: size),
      new Text(content,
          softWrap: true, textScaleFactor: 0.85, textAlign: TextAlign.center)
    ]);
  }

  _getMovieListBody(LAYOUT_TYPE layoutType) {
    print('getting movie list body with type $layoutType');
    switch (layoutType) {
      case LAYOUT_TYPE.GRID:
        return _getGridViewList();
      case LAYOUT_TYPE.LIST:
        return _getVerticalViewList();
      case LAYOUT_TYPE.POSTER:
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
        childAspectRatio: 9 / 17 * 1.0,
        crossAxisSpacing: 7.0,
        children: new List.generate(10, (index) {
          return new Column(
            children: <Widget>[
              new Image(image: new AssetImage('assets/images/movie.jpg')),
              new Padding(padding: new EdgeInsets.only(top: 5.0, bottom: 5.0)),
              new Column(
                children: <Widget>[
                  new Text('movie movie', textScaleFactor: 1.2),
                  new Row(
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
                  )
                ],
              )
            ],
          );
        }));
  }

  _showViewType(LAYOUT_TYPE toViewType) {
    setState(() {
      _layoutType = toViewType;
    });
  }

  IconButton _getMovieListTypeAction() {
    return new IconButton(
        icon: new Icon(_layoutDefinition[_layoutType][layoutDefinitionKeys.ICON]),
        onPressed: () {
          print('action icon clicked');
          print(
              'show change to type: ${_layoutDefinition[_layoutType][layoutDefinitionKeys.NEXT_TYPE]}');
          _showViewType(_layoutDefinition[_layoutType][layoutDefinitionKeys.NEXT_TYPE]);
        });
  }

  Widget _getPosterViewList() {
    return new Text('hi in poster view list');
  }

  Widget _verticalListItemWidget(int item, int index) {
    return new Container(
      child: new ListTile(
        leading: new Image(image: AssetImage('assets/images/movie.jpg')),
        title: new Text('movie movie'),
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
