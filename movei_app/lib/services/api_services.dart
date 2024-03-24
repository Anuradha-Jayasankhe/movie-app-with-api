import 'dart:convert';

import 'package:http/http.dart';
import 'package:movei_app/models/movie_details_model.dart';
import 'package:movei_app/models/movies_model.dart';

class ApiServices {
  final apikey = "api_key=8c927debb6ac84f539d41e9a8ac29876";
  final populer = "https://api.themoviedb.org/3/movie/popular?";
  //get populer movies

  Future<List<Movie>> getmovies({required int page}) async {
    //send requste
    Response response = await get(Uri.parse("$populer$apikey&page=$page"));
    //check response
    if (response.statusCode == 200) {
      //extract respons body
      Map<String, dynamic> body = jsonDecode(response.body);
      //extract result from body
      List<dynamic> data = body["results"];
      //map to movie model
      List<Movie> movies = data.map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MovieDetailsModel> getdetails({required String id}) async {
    Response response =
        await get(Uri.parse("https://api.themoviedb.org/3/movie/$id?$apikey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(json);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
