import 'package:flutter/material.dart';
import 'package:movei_app/models/movie_details_model.dart';
import 'package:movei_app/models/movies_model.dart';
import 'package:movei_app/services/api_services.dart';

class MovieDetails extends StatefulWidget {
  Movie movie;
  MovieDetails({required this.movie, super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  ApiServices service = ApiServices();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Details",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: service.getdetails(id: widget.movie.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MovieDetailsModel data = snapshot.data!;
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken),
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${widget.movie.backdrop_path.toString()}"))),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.movie.title.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          height: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${widget.movie.poster_path.toString()}"))),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.1,
                              width: size.width * 05,
                              color: Colors.grey,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Title: ${widget.movie.title.toString()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      " Release Date:  ${widget.movie.release_date.toString()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    )
                                    // Text(
                                    //   data.tagline.toString(),
                                    //   style: const TextStyle(
                                    //       fontWeight: FontWeight.bold),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.movie.overview.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  data.companies!.isEmpty
                      ? const SizedBox()
                      : const Text(
                          "production companies",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        data.companies!.length,
                        (index) => data.companies![index].logo.toString() == ""
                            ? const SizedBox()
                            : Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        "https://image.tmdb.org/t/p/w500${data.companies![index].logo.toString()}",
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Text(data.companies![index].name
                                          .toString()),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
