import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weight_tracker/model.dart/day.dart';
import 'package:weight_tracker/model.dart/state.dart';
import 'package:weight_tracker/model.dart/user.dart';
import 'package:weight_tracker/pages/home/graph_tile.dart';
import 'package:weight_tracker/pages/home/input_tile.dart';
import 'package:weight_tracker/pages/home/summary_tile.dart';
import 'package:weight_tracker/pages/init/init_page.dart';
import 'package:weight_tracker/pages/setup/setup_page.dart';
import 'package:weight_tracker/redux/actions.dart';

class HomePage extends StatelessWidget {
  static final String route = "/home";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (Store<AppState> store) {
          if (store.state.appVariables.hasLoaded == null ||
              !store.state.appVariables.hasLoaded) {
            store.dispatch(GetDataAction());
          }
        },
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => SafeArea(
              child: HomePageWidget(viewModel),
            ));
  }
}

class HomePageWidget extends StatefulWidget {
  final _ViewModel model;

  HomePageWidget(this.model);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final List<List<double>> charts = [
    [2.6, 2.7, 2.9, 2.8, 3.4],
    [
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [2.6, 2.7, 2.9, 2.8, 3.4]
  ];

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context) {
    _ViewModel model = widget.model;
    User user = model.user;
    List<Day> days = model.days;
    DateTime today = DateTime.now();
    Day lastDay;
    Day dayToday;
    if (days.length > 0) {
      lastDay = days[days.length - 1];
      dayToday = lastDay.date.difference(today).inDays == 0
          ? dayToday = lastDay
          : null;
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Color(0xFFBE90EC),
          title: Text('getfat',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0)),
          
        ),
        body: Container(
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              SummaryTile(
                dayToday: dayToday,
                user: user,
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => InitPage())),
              ),
              InputTile(
                dayToday: dayToday,
                user: user,
                onTap: widget.model.addWeight,
              ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('173',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.0)),
                            Text('guests',
                                style: TextStyle(
                                    color: Colors.blue, fontFamily: 'Raleway')),
                          ],
                        ),
                        Material(
                            color: Colors.blueAccent[100],
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.people,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ),
                // onTap: () => Navigator.of(context).push(
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => GuestListPage())),
              ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('17',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.0)),
                            Text('tables',
                                style: TextStyle(
                                    color: Colors.blue, fontFamily: 'Raleway')),
                          ],
                        ),
                        Material(
                            color: Colors.yellowAccent[700],
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.local_dining,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => SetupPage())),
              ),
              GraphTile(days: widget.model.days)
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(1, 110.0),
              StaggeredTile.extent(1, 110.0),
              StaggeredTile.extent(2, 220.0),

              // StaggeredTile.extent(2, 110.0),
            ],
          ),
        ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            borderRadius: BorderRadius.circular(12.0),
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}

class _ViewModel {
  final User user;
  final List<Day> days;
  final Function(double) addWeight;

  _ViewModel(
      {@required this.user, @required this.days, @required this.addWeight});

  factory _ViewModel.create(Store<AppState> store) {
    _addWeight(double weight) {
      store.dispatch(AddWeightAction(weight, DateTime.now()));
    }

    return _ViewModel(
        user: store.state.user, days: store.state.days, addWeight: _addWeight);
  }
}
