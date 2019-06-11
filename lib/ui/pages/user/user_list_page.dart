import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/ui/widgets/general/scroll_list.dart';
import 'package:tv_series_jokes/ui/widgets/user/user_card.dart';

class UserListPage extends StatefulWidget {
  final bool showFollowDetails;
  final String title;
  UserListPage({Key key, this.showFollowDetails = false, this.title}) : super(key: key);

  @override
  _UserListPageState createState() => new _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  UserListBloc _userListBloc;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      _userListBloc = BlocProvider.of<UserListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text((widget.title != null)? widget.title : 'Users' ),),
      body: ScrollList<User>(
      scrollListType: ScrollListType.list,
      listContentStream: _userListBloc.items,
      loadStateStream: _userListBloc.loadState,
      loadMoreAction: (){
        _userListBloc.getItems();
      },
      listItemWidget: (user, index){
        return UserCard(user: user, showFollowDetails: widget.showFollowDetails,);
      },

    ),
    );
  }
}