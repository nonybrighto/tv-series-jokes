import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/ui/widgets/general/main_error_display.dart';

enum ScrollListType{
  grid,
  list
}

class ScrollList<T> extends StatefulWidget {
  final Stream<LoadState> loadStateStream;
  final Stream<UnmodifiableListView<T>> listContentStream;
  final Function loadMoreAction;
  final Widget Function(T, int) listItemWidget;
  final ScrollListType scrollListType;
  final int gridCrossAxisCount;
  final PageStorageKey pageStorageKey;

  ScrollList({Key key, this.loadStateStream, this.listContentStream, this.loadMoreAction, this.listItemWidget, @required this.scrollListType, this.gridCrossAxisCount, this.pageStorageKey}) : super(key: key){

      if(scrollListType == ScrollListType.grid && gridCrossAxisCount == null ||
        gridCrossAxisCount != null && scrollListType != ScrollListType.grid
      ){
          throw 'Grid should have a count or type should be grid';
      }

  }


  @override
  _ScrollListState<T> createState() => new _ScrollListState<T>();

}

class _ScrollListState<T> extends State<ScrollList<T>> {

  ScrollController _scrollController = new ScrollController();
  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000 && canLoadMore) {
        widget.loadMoreAction();
      canLoadMore = false;
    }
  }


  

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<LoadState>(
      stream: widget.loadStateStream,
      builder: (BuildContext context,AsyncSnapshot<LoadState> snapshot){
        LoadState loadState =snapshot.data;

        if(loadState is LoadComplete && !(loadState is LoadEnd) && !(loadState is ErrorLoad)){
           canLoadMore = true;
        }else{
          canLoadMore = false;
        }

        return Stack(
          children: <Widget>[

              _initialProgress(visible: loadState is Loading),
              _initialError(loadState , visible: loadState is LoadError, onRetry: (){ 
                widget.loadMoreAction();
                }),
              _showEmpty(loadState, visible: loadState is LoadEmpty),
              _contentList(loadState, widget.pageStorageKey, visible: !(loadState is Loading) && !(loadState is LoadEmpty) && !(loadState is LoadError)),
              _moreError(loadState, visible: loadState is LoadMoreError,  onRetry: (){ 
                  widget.loadMoreAction(); 
                }),
          ],
        );
      },
      
    );
  }

  _initialProgress({bool visible}){

      if(visible){
        return Center(
          child: CircularProgressIndicator(),
        );
      }else{
        return _dumbPlaceHolder();
      }
  }

  _dumbPlaceHolder(){
        return Container(
          width: 0,
          color: Colors.red,
        );
  }

  _initialError(LoadState error, {bool visible, Function onRetry}){

    if(visible){
        return MainErrorDisplay(errorMessage: (error as LoadError).message, buttonText: 'RETRY', onErrorButtonTap: onRetry,);
    }else{
       return _dumbPlaceHolder();
    }
  }
  _moreError(LoadState error, {bool visible, Function onRetry}){

    if(visible){
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ListTile(title: Text((error as LoadMoreError).message), trailing: RaisedButton(child:  Text('RETRY'), onPressed: (){
                  print('reload more pressed');
                  onRetry();
                })));
    }else{
      return _dumbPlaceHolder();
    }
  }

  _showEmpty(LoadState loadState, {bool visible}){
     
     if(visible){
        return Center(
          child: Text((loadState as LoadEmpty).message),
        );
     }else{
        return _dumbPlaceHolder();
     }
     
  }

  _contentList(LoadState loadState,PageStorageKey pageStorageKey, {bool visible}){

    if(visible){
      return StreamBuilder<UnmodifiableListView<T>>(
            initialData: UnmodifiableListView([]),
            stream: widget.listContentStream,
            builder: (BuildContext context, AsyncSnapshot<UnmodifiableListView<T>> listItemSnapshot){
              UnmodifiableListView<T> listItems = listItemSnapshot.data;
               return (widget.scrollListType == ScrollListType.list)?_buildListView(loadState, listItems, pageStorageKey)
                :_buildGridView(loadState, listItems);
            },
      );
    }else{
      return _dumbPlaceHolder();
    }
    
  }


  _buildListView(LoadState loadState, UnmodifiableListView<T> listItems,  PageStorageKey pageStorageKey){
    return ListView.builder(
                    key: pageStorageKey,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    controller: _scrollController,
                    itemCount: (loadState is LoadingMore) ? listItems.length + 1 : listItems.length,
                    itemBuilder: (BuildContext context, int index){
                      return (index < listItems.length ) ? widget.listItemWidget(listItems[index], index) : _buildBottomProgress();
                    },
                );
  }

  _buildGridView(LoadState loadState, UnmodifiableListView<T> listItems){

        return new CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
       SliverGrid(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridCrossAxisCount,
          ),

          delegate: SliverChildBuilderDelegate(

            (BuildContext context, int index) {
              return widget.listItemWidget(listItems[index], index);
            },
            childCount: listItems.length,
        )),
        SliverToBoxAdapter(
          child: (loadState is LoadingMore)?_buildBottomProgress():Container(),
        ),
      ]);
  }

  _buildBottomProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  
}