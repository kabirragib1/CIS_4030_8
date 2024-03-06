import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';

class topRatedMoviesSlider extends StatelessWidget {
  const topRatedMoviesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
         // apply scroll effects
        physics: const BouncingScrollPhysics(),
        itemCount: 10, // show 10 movies 
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 200,
                  width: 150,
                  color: Color.fromARGB(255, 250, 178, 54),
                ),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  MoviePage()));
              }
            )  
          );
        },
      ),
    );
  }
}