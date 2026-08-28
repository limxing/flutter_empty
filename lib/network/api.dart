import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {required String baseUrl}) = _Api;

  @POST("/demo")
  Future<dynamic> demo(@Query("type") int type, @Body() Map<String,dynamic> body );
}
