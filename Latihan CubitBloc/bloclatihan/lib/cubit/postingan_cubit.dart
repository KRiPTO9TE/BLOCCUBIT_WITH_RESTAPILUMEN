import 'package:bloc/bloc.dart';
import 'package:bloclatihan/models/postingan_model.dart';
import 'package:bloclatihan/services/postingan_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

part 'postingan_state.dart';

class PostinganCubit extends Cubit<PostinganState> {
  final PostinganService dioHelper;

  PostinganCubit(this.dioHelper) : super(InitialPostinganState());

  void getAllPostingans() async {
    emit(LoadingPostinganState());
    var result = await dioHelper.getAllPostingans();
    result.fold(
      (errorMessage) => emit(FailureLoadAllPostinganState(errorMessage)),
      (listPostingans) => emit(
          SuccessLoadAllPostinganState(listPostingans, message: 'berhasil')),
    );
  }

  void addPostingan(PostinganData postinganData) async {
    emit(LoadingPostinganState());
    var result = await dioHelper.addPostingan(postinganData);
    result.fold(
      (errorMessage) => emit(FailureSubmitPostinganState(errorMessage)),
      (_) => emit(SuccessSubmitPostinganState()),
    );
  }

  void editPostingan(PostinganData postinganData) async {
    emit(LoadingPostinganState());
    var result = await dioHelper.editPostingan(postinganData);
    result.fold(
      (errorMessage) => emit(FailureSubmitPostinganState(errorMessage)),
      (_) => emit(SuccessSubmitPostinganState()),
    );
  }

  void deletePostingan(int id) async {
    emit(LoadingPostinganState());
    var resultDelete = await dioHelper.deletePostingan(id);
    var resultDeleteFold = resultDelete.fold(
      (errorMessage) => errorMessage,
      (response) => response,
    );
    if (resultDeleteFold is String) {
      emit(FailureDeletePostinganState(resultDeleteFold));
      return;
    }
    var resultGetAllPostingans = await dioHelper.getAllPostingans();
    resultGetAllPostingans.fold(
      (errorMessage) => emit(FailureLoadAllPostinganState(errorMessage)),
      (listPostingans) => emit(
        SuccessLoadAllPostinganState(
          listPostingans,
          message: 'Postingan data deleted successfully',
        ),
      ),
    );
  }
}
