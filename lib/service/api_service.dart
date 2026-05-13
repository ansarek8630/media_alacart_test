// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import '../../utils/utils.dart';
// part 'api_services.g.dart';

// @RestApi(baseUrl: 'https://api.nytimes.com/svc/topstories/v2')
// abstract class ApiServices {
//   factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;
//   @GET(EndPoints.getAllTopStories)
//   Future<TopStoriesModel> getTopStories(
//     @Query("api-key") String apiKey,
//   );
// }
