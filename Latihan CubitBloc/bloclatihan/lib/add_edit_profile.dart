import 'dart:io';

import 'package:bloclatihan/services/postingan_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloclatihan/cubit/postingan_cubit.dart';
import 'package:bloclatihan/models/postingan_model.dart';

class AddEditPostingan extends StatefulWidget {
  final PostinganData postinganData;

  AddEditPostingan({
    required this.postinganData,
  });

  @override
  _AddEditPostinganState createState() => _AddEditPostinganState();
}

class _AddEditPostinganState extends State<AddEditPostingan> {
  final postinganCubit = PostinganCubit(PostinganService());
  final scaffoldState = GlobalKey<ScaffoldState>();
  final formState = GlobalKey<FormState>();
  final focusNodeButtonSubmit = FocusNode();
  var controllerTitle = TextEditingController();
  var controllerContent = TextEditingController();
  var isEdit = false;
  var isSuccess = false;

  @override
  void initState() {
    isEdit = widget.postinganData.id != 0;
    if (isEdit) {
      controllerTitle.text = widget.postinganData.title;
      controllerContent.text = widget.postinganData.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSuccess) {
          Navigator.pop(context, true);
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text(widget.postinganData.id != 0
              ? 'Add Postingan'
              : 'Edit Postingan'),
        ),
        body: BlocProvider<PostinganCubit>(
          create: (_) => postinganCubit,
          child: BlocListener<PostinganCubit, PostinganState>(
            listener: (_, state) {
              if (state is SuccessSubmitPostinganState) {
                isSuccess = true;
                if (isEdit) {
                  Navigator.pop(context, true);
                } else {
                  print(state);
                  setState(() {
                    controllerTitle.clear();
                    controllerContent.clear();
                  });
                }
              } else if (state is FailureSubmitPostinganState) {
                print(state);
                print(state.errorMessage);
              }
            },
            child: Stack(
              children: [
                _buildWidgetForm(),
                _buildWidgetLoading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetForm() {
    return Form(
      key: formState,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controllerTitle,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                return value == null || value.isEmpty ? 'Enter a title' : null;
              },
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              controller: controllerContent,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              validator: (value) {
                debugPrint('value content: $value');
                return value == null || value.isEmpty ? 'Enter content' : null;
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('SUBMIT'),
                focusNode: focusNodeButtonSubmit,
                onPressed: () {
                  focusNodeButtonSubmit.requestFocus();
                  if (formState.currentState!.validate()) {
                    var title = controllerTitle.text.trim();
                    var content = controllerContent.text.trim();
                    if (isEdit) {
                      var postinganData = PostinganData(
                        id: widget.postinganData.id,
                        title: title,
                        content: content,
                      );
                      postinganCubit.editPostingan(postinganData);
                    } else {
                      var postinganData = PostinganData(
                        title: title,
                        content: content,
                        id: widget.postinganData.id,
                      );
                      postinganCubit.addPostingan(postinganData);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetLoading() {
    return BlocBuilder<PostinganCubit, PostinganState>(
      builder: (_, state) {
        if (state is LoadingPostinganState) {
          return Container(
            color: Colors.black.withOpacity(.5),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
