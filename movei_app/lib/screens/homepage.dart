import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movei_app/models/movies_model.dart';
import 'package:movei_app/screens/movie_details.dart';
import 'package:movei_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices service = ApiServices();
  List<Movie> movies = [];
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // Show the pop-up container when the IconButton is pressed
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.grey[400],
                            height: 400,
                            width: 400,
                            child: const Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    CircleAvatar(
                                      radius: 50,
                                      child: CircleAvatar(
                                        radius:
                                            48, // Adjust the size of the inner CircleAvatar to fit within the outer CircleAvatar
                                        backgroundImage: NetworkImage(
                                          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const Text(
                    "TMDB Movies",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const Icon(Icons.favorite)
                ],
              ),
              FutureBuilder(
                future: service.getmovies(page: page),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    movies = [...movies, ...snapshot.data!];
                    movies = movies.toSet().toList();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.59),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MovieDetails(movie: movies[index]),
                                ));
                          },
                          child: Column(
                            children: [
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/w500${movies[index].poster_path}"))),
                                ),
                              ),
                              Text(
                                movies[index].title.toString(),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      page++;
                      //page up
                    });
                  },
                  child: const Text("Load More"))
            ],
          ),
        ),
      ),
    );
  }
}
