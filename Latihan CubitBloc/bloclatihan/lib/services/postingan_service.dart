import 'dart:convert';

import 'package:bloclatihan/models/postingan_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

class PostinganService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.100.115:8000/api',
    ),
  );

  DioHelper() {
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Either<String, List<PostinganData>>> getAllPostingans() async {
    try {
      var response = await _dio.get('/posts');
      Map<String, dynamic> map = response.data;
      List<dynamic> dataaa = map["data"];
      List<PostinganData> tes =
          dataaa.map((data) => new PostinganData.fromJson(data)).toList();
      return Right(tes);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> addPostingan(PostinganData postinganData) async {
    try {
      await _dio.post(
        '/newposts',
        data: postinganData.toJson(),
      );
      return Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> editPostingan(
      PostinganData postinganData) async {
    try {
      await _dio.put(
        '/posts/update/${postinganData.id}',
        data: postinganData.toJson(),
      );
      return Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> deletePostingan(int id) async {
    try {
      await _dio.delete(
        '/posts/delete/$id',
      );
      return Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }
}
