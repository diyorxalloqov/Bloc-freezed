import 'package:bloc_freezed/domain/model/userModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<Either<String, List<UserModel>>> getUser() async {
    try {
      Response response = await Dio(BaseOptions(
          sendTimeout: const Duration(seconds: 55),
          receiveTimeout: const Duration(seconds: 55),
          connectTimeout: const Duration(seconds: 55),
          responseType: ResponseType.json,
          validateStatus: (status) {
            if (status! >= 100 && status <= 599) {
              return true;
            } else {
              return false;
            }
          })).get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        return right(
            (response.data as List).map((e) => UserModel.fromJson(e)).toList());
      } else if (response.statusCode == 404) {
        return left("xatolik 404 status code");
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return left("Iltimos to'gri so'rov jo'nating");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        return left("Bog'lanishda xatolik");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return left("serverda javobida xatolik");
      } else if (e.type == DioExceptionType.sendTimeout) {
        return left("Ma'lumot jo'natishda xatolik");
      } else if (e.type == DioExceptionType.unknown) {
        return left("Iltimos Internetingizni tekshirig");
      } else {
        return left(e.message.toString());
      }
    }
  }
}
