import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/ui/widgets/general/scroll_list.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_card.dart';



class JokeList extends StatefulWidget {
  final PageStorageKey pageStorageKey;
  JokeList({Key key, this.pageStorageKey}) : super(key: key);

  @override
  _JokeListState createState() => new _JokeListState();
}

class _JokeListState extends State<JokeList> {

 JokeListBloc jokeListBloc;

 
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     jokeListBloc = BlocProvider.of<JokeListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return  ScrollList<Joke>(
      scrollListType: ScrollListType.list,
      listContentStream: jokeListBloc.items,
      loadStateStream: jokeListBloc.loadState,
      pageStorageKey: widget.pageStorageKey,
      loadMoreAction: (){
        jokeListBloc.getItems();
      },
      listItemWidget: (joke, int index){

            return JokeCard(index, joke:joke);
      },

    );

  }

 
}

