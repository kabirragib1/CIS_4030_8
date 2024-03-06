import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class trendingMovieSlider extends StatelessWidget {
  const trendingMovieSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, 
      child: CarouselSlider.builder(
        itemCount: 10, // show 10 movies 
        options: CarouselOptions(
          height: 300,
          autoPlay: true, // auto play the trending movies
          autoPlayInterval: const Duration(seconds: 2), // interval for the movies to rotate
          viewportFraction: 0.55, // fraction of the viewport that each item occupies
          enlargeCenterPage: true, // make center movie larger 
          pageSnapping: true,
          autoPlayCurve: Curves.easeInOutCirc,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 300,
                width: 200,
                color: Color.fromARGB(255, 250, 178, 54),
              ),
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  MoviePage()));
            }
          );  
        } 
      ),
    );
  }
}