import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/ui/widgets/general/main_error_display.dart';

enum ScrollListType { grid, list }

class ScrollList<T> extends StatefulWidget {
  final Stream<LoadState> loadStateStream;
  final Stream<UnmodifiableListView<T>> listContentStream;
  final Function loadMoreAction;
  final Widget Function(T, int) listItemWidget;
  final ScrollListType scrollListType;
  final int gridCrossAxisCount;
  final PageStorageKey pageStorageKey;

  ScrollList(
      {Key key,
      this.loadStateStream,
      this.listContentStream,
      this.loadMoreAction,
      this.listItemWidget,
      @required this.scrollListType,
      this.gridCrossAxisCount,
      this.pageStorageKey})
      : super(key: key) {
    if (scrollListType == ScrollListType.grid && gridCrossAxisCount == null ||
        gridCrossAxisCount != null && scrollListType != ScrollListType.grid) {
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
      builder: (BuildContext context, AsyncSnapshot<LoadState> snapshot) {
        LoadState loadState = snapshot.data;

        if (loadState is LoadComplete &&
            !(loadState is LoadEnd) &&
            !(loadState is ErrorLoad)) {
          canLoadMore = true;
        } else {
          canLoadMore = false;
        }

        if (loadState is Loading) {
          return _initialProgress();
        } else if (loadState is LoadError) {
          return _initialError(loadState.message, onRetry: () {
            widget.loadMoreAction();
          });
        } else if (loadState is LoadEmpty) {
          return _showEmpty(loadState.message);
        } else {
          return _contentList(loadState, widget.pageStorageKey);
        }
        // _initialError(loadState , visible: loadState is LoadError, onRetry: (){
        //   widget.loadMoreAction();
        //   }),
        // _showEmpty(loadState, visible: loadState is LoadEmpty),
        // _contentList(loadState, widget.pageStorageKey, visible: !(loadState is Loading) && !(loadState is LoadEmpty) && !(loadState is LoadError)),
        // _moreError(loadState, visible: loadState is LoadMoreError,  onRetry: (){
        //     widget.loadMoreAction();
      },
    );
  }

  _initialProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _initialError(String message, {Function onRetry}) {
    return MainErrorDisplay(
      errorMessage: message,
      buttonText: 'RETRY',
      onErrorButtonTap: onRetry,
    );
  }

  _moreError(String message, {Function onRetry}) {
    return ListTile(
        title: Text(message),
        trailing: RaisedButton(
            child: Text('RETRY'),
            onPressed: () {
              print('reload more pressed');
              onRetry();
            }));
  }

  _showEmpty(String message) {
    return Center(
      child: Text(message),
    );
  }

  _contentList(LoadState loadState, PageStorageKey pageStorageKey) {
    return StreamBuilder<UnmodifiableListView<T>>(
      initialData: UnmodifiableListView([]),
      stream: widget.listContentStream,
      builder: (BuildContext context,
          AsyncSnapshot<UnmodifiableListView<T>> listItemSnapshot) {
        UnmodifiableListView<T> listItems = listItemSnapshot.data;
        return (widget.scrollListType == ScrollListType.list)
            ? _buildListView(loadState, listItems, pageStorageKey)
            : _buildGridView(loadState, listItems);
      },
    );
  }

  _buildListView(LoadState loadState, UnmodifiableListView<T> listItems,
      PageStorageKey pageStorageKey) {
    return ListView.builder(
      key: pageStorageKey,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      controller: _scrollController,
      itemCount: (loadState is LoadingMore || loadState is LoadMoreError)
          ? listItems.length + 1
          : listItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < listItems.length) {
          return widget.listItemWidget(listItems[index], index);
        } else if (loadState is LoadingMore) {
          return _buildBottomProgress();
        } else if (loadState is LoadMoreError) {
          return _moreError(loadState.message, onRetry: () {
            widget.loadMoreAction();
          });
        }
      },
    );
  }

  _buildGridView(LoadState loadState, UnmodifiableListView<T> listItems) {
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
            child: (loadState is LoadingMore)
                ? _buildBottomProgress()
                : (loadState is LoadMoreError)
                    ? _moreError(loadState.message, onRetry: () {
                        widget.loadMoreAction();
                      })
                    : Container(),
          ),
        ]);
  }

  _buildBottomProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
