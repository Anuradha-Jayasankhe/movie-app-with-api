class Movie {
  String? poster_path;
  String? overview;
  int? id;
  String? title;
  String? backdrop_path;
  String? release_date;

  Movie(
      {this.backdrop_path,
      this.id,
      this.overview,
      this.poster_path,
      this.title,
      this.release_date});

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
        release_date: map['release_date'],
        backdrop_path: map["backdrop_path"],
        id: map["id"],
        overview: map["overview"],
        poster_path: map["poster_path"],
        title: map["title"]);
  }
}
