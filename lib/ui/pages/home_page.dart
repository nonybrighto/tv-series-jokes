import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/application_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/ui/widgets/app_drawer.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_add_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key,}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  ApplicationBloc appBloc;

  List<Widget> _homeItems;
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  JokeService jokeService = JokeService();
  JokeListBloc latestJokeListBloc;
  JokeListBloc popularJokeListBloc;

  @override
  void initState() {
    super.initState();
    latestJokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes, close: false);
    popularJokeListBloc = JokeListBloc(jokeService: jokeService, fetchType:  JokeListFetchType.popularJokes, close: false);
    _homeItems = [
                 BlocProvider<JokeListBloc>(
                    key: UniqueKey(),
                    bloc: latestJokeListBloc,
                    child: JokeList(pageStorageKey: PageStorageKey<String>('latest'),),
              ),
                 BlocProvider<JokeListBloc>(
                    key: UniqueKey(),
                    bloc: popularJokeListBloc,
                    child: JokeList(pageStorageKey: PageStorageKey<String>('popular'),),
              ),
              
              
            
            ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appBloc =BlocProvider.of<ApplicationBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text('TvSeries Jokes')
          ),
          body: PageView(
            children: _homeItems,
            controller: _pageController,
            onPageChanged: (index){
                  setState(() {
                    _selectedIndex = index; 
                  });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Latest')),
                  BottomNavigationBarItem(icon: Icon(Icons.sentiment_satisfied), title: Text('Popular')),
            ],
            onTap: (index){
                _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease
                );
            },
          ),
          floatingActionButton: JokeAddButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ),
      );
  }

  

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    latestJokeListBloc.dispose();
    popularJokeListBloc.dispose();

  }
}