part of 'postingan_cubit.dart';

abstract class PostinganState {}

class InitialPostinganState extends PostinganState {}

class LoadingPostinganState extends PostinganState {}

class FailureLoadAllPostinganState extends PostinganState {
  final String errorMessage;

  FailureLoadAllPostinganState(this.errorMessage);

  @override
  String toString() {
    return 'FailureLoadAllPostinganState{errorMessage: $errorMessage}';
  }
}

class SuccessLoadAllPostinganState extends PostinganState {
  final List<PostinganData> listPostingans;
  final String message;

  SuccessLoadAllPostinganState(this.listPostingans, {required this.message});

  @override
  String toString() {
    return 'SuccessLoadAllPostinganState{listPostingans: $listPostingans, message: $message}';
  }
}

class FailureSubmitPostinganState extends PostinganState {
  final String errorMessage;

  FailureSubmitPostinganState(this.errorMessage);

  @override
  String toString() {
    return 'FailureSubmitPostinganState{errorMessage: $errorMessage}';
  }
}

class SuccessSubmitPostinganState extends PostinganState {}

class FailureDeletePostinganState extends PostinganState {
  final String errorMessage;

  FailureDeletePostinganState(this.errorMessage);

  @override
  String toString() {
    return 'FailureDeletePostinganState{errorMessage: $errorMessage}';
  }
}
