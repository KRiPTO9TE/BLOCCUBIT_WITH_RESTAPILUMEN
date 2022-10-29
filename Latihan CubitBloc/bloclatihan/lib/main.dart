import 'dart:io';

import 'package:bloclatihan/addpostingan.dart';
import 'package:bloclatihan/models/postingan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/postingan_cubit.dart';
import 'package:bloclatihan/services/postingan_service.dart';
import 'package:bloclatihan/add_edit_profile.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPostinganPage(),
    );
  }
}

class ListPostinganPage extends StatefulWidget {
  @override
  _ListPostinganPageState createState() => _ListPostinganPageState();
}

class _ListPostinganPageState extends State<ListPostinganPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  late PostinganCubit postinganCubit;

  @override
  void initState() {
    postinganCubit = PostinganCubit(PostinganService());
    postinganCubit.getAllPostingans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Flutter CRUD Cubit'),
      ),
      body: BlocProvider<PostinganCubit>(
        create: (_) => postinganCubit,
        child: BlocListener<PostinganCubit, PostinganState>(
          listener: (_, state) {
            if (state is FailureLoadAllPostinganState) {
              print('gagal $state');
            } else if (state is FailureDeletePostinganState) {
              print('gagal hapus $state');
            } else if (state is SuccessLoadAllPostinganState) {
              if (state.message != null && state.message.isNotEmpty)
                print('berhasilload $state');
            }
          },
          child: BlocBuilder<PostinganCubit, PostinganState>(
            builder: (_, state) {
              if (state is LoadingPostinganState) {
                return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                );
              } else if (state is FailureLoadAllPostinganState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is SuccessLoadAllPostinganState) {
                var listPostingans = state.listPostingans;
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: listPostingans.length,
                  itemBuilder: (_, index) {
                    var postinganData = listPostingans[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postinganData.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              postinganData.content,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              '${postinganData.id}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    'DELETE',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () async {
                                    var dialogConfirmDelete = Platform.isIOS
                                        ? await showCupertinoDialog<bool>(
                                            context: context,
                                            builder: (_) {
                                              return CupertinoAlertDialog(
                                                title: Text('Warning'),
                                                content: Text(
                                                  'Are you sure you want to delete ${postinganData.title}\'s data?',
                                                ),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: Text('Delete'),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    isDestructiveAction: true,
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : await showDialog<bool>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text('Warning'),
                                                content: Text(
                                                  'Are you sure you want to delete ${postinganData.title}\'s data?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                    if (dialogConfirmDelete != null &&
                                        dialogConfirmDelete) {
                                      postinganCubit
                                          .deletePostingan(postinganData.id);
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('EDIT',
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddEditPostingan(
                                          postinganData: postinganData,
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      postinganCubit.getAllPostingans();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPostingan()),
          );
          if (result != null) {
            postinganCubit.getAllPostingans();
          }
        },
      ),
    );
  }
}
