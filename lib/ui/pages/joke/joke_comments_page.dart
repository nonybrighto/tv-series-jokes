import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_comment_add_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_comment_list_bloc.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/ui/widgets/general/scroll_list.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_comment_card.dart';

class JokeCommentPage extends StatefulWidget {
  JokeCommentPage({Key key}) : super(key: key);

  @override
  _JokeCommentPageState createState() => new _JokeCommentPageState();
}

class _JokeCommentPageState extends State<JokeCommentPage> {
  JokeCommentListBloc _commentListBloc;
  JokeCommentAddBloc _commentAddBloc;

  final _formKey = GlobalKey<FormState>();
  TextEditingController anonymousNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentListBloc = BlocProvider.of<JokeCommentListBloc>(context);
    _commentAddBloc = JokeCommentAddBloc(
        jokeCommentListBloc: _commentListBloc, jokeService: JokeService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ScrollList<Comment>(
              scrollListType: ScrollListType.list,
              listContentStream: _commentListBloc.items,
              loadStateStream: _commentListBloc.loadState,
              loadMoreAction: () {
                _commentListBloc.getItems();
              },
              listItemWidget: (comment, index) {
                return JokeCommentCard(comment);
              },
            ),
          ),
          _buildCommentBox(),
        ],
      ),
    );
  }

  _buildCommentBox() {
    return BlocProvider<JokeCommentAddBloc>(
      bloc: _commentAddBloc,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: StreamBuilder<bool>(
            initialData: false,
            stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
            builder: (context, isAuthenticatedSnapshot) {
              bool isAuthenticated = isAuthenticatedSnapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    (!isAuthenticated)
                        ? TextFormField(
                            controller: anonymousNameController,
                            decoration: InputDecoration(
                              hintText: 'name...',
                              helperText: 'login to hide this box',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty && value.trim().isEmpty) {
                                return 'Please input at least 1 character';
                              }
                            },
                          )
                        : Container(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: contentController,
                            decoration: InputDecoration(hintText: 'comment...'),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Field is required';
                              }
                            },
                          ),
                        ),
                        StreamBuilder<LoadState>(
                            initialData: Loaded(),
                            stream: _commentAddBloc.loadState,
                            builder: (context, loadStateSnapshot) {
                              return IconButton(
                                icon: (loadStateSnapshot.data is Loading)? CircularProgressIndicator() :Icon(Icons.send),
                                onPressed: (!(loadStateSnapshot.data is Loading))?() {
                                  if (_formKey.currentState.validate()) {
                                    _commentAddBloc.addComment(
                                        contentController.text,
                                        anonymousNameController.text,
                                        (bool commentAdded,
                                            String commentMessage) {
                                      if (commentAdded) {
                                        contentController.text = '';
                                      } 
                                      Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(commentMessage),
                                        ));
                                    });
                                  }
                                }: null,
                              );
                            })
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
