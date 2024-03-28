import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cinequest/constants.dart';

class ViewReviewPage extends StatefulWidget {
  final String movie_image_path;
  final String movie_title;
  final double movie_vote_avg;
  final int movieId;

  ViewReviewPage({
    required this.movie_image_path,
    required this.movie_title,
    required this.movie_vote_avg,
    required this.movieId,
  });

  @override
  _ViewReviewPageState createState() => _ViewReviewPageState();
}

class _ViewReviewPageState extends State<ViewReviewPage> {
  List<dynamic> reviews = [];
  bool isLoading = true;
  String dropdownValue = 'Reviews from our app'; //Set default dropdown option

  @override
  void initState() {
    super.initState();
    if (dropdownValue == 'Reviews from our app') {
      fetchReviews();
    }
  }

  Future<void> fetchReviews() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/${widget.movieId}/reviews?api_key=${Constants.API_key}&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      setState(() {
        reviews = jsonDecode(response.body)['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load reviews: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 80,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(child: Text(widget.movie_title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                const SizedBox(height: 15.0),
                Center(
                    child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Image.network(
                          '${Constants.image_path}${widget.movie_image_path}',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('FILM SCORE: ${widget.movie_vote_avg.toStringAsFixed(2)}/10.0', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                ),
                //Dropdown Menu
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0), 
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white), // Adds a white border
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    elevation: 16,
                    dropdownColor: Colors.black, // Change dropdown background color
                    style: const TextStyle(color: Colors.white),
                    underline: Container(
                      height: 0, 
                    ),
                    onChanged: (String? newValue) { 
                      if (newValue != null) { 
                        setState(() {
                          dropdownValue = newValue;
                        });
                        if (newValue == 'Reviews from our app') {
                          fetchReviews(); // Fetch reviews when 'Reviews from our app' is selected
                        } else {
                          reviews.clear(); // Clear reviews for other options
                          isLoading = false;
                        }
                      }
                    },
                    items: <String>['Reviews from IMDb', 'Reviews from Rotten Tomatoes', 'Reviews from our app']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.white)), // Text color inside the dropdown
                      );
                    }).toList(),
                  ),
                ),
                const Divider(
                  thickness: 3.0,
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Colors.white,
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('AUDIENCE REVIEWS:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          if (dropdownValue == 'Reviews from our app' && !isLoading) 
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final review = reviews[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['author'] ?? 'Unknown',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < (review['author_details']['rating'] ?? 0) / 2 ? Icons.star : Icons.star_border,
                                color: Colors.yellow,
                              );
                            }),
                          ),
                          SizedBox(height: 10),
                          Text(review['content'] ?? 'No review text.'),
                        ],
                      ),
                    );
                  },
                  childCount: reviews.length,
                ),
              ),
            )
          else 
            // When 'Reviews from IMDb' or 'Reviews from Rotten Tomatoes' is selected
            // or when isLoading is true, show an empty or placeholder widget
            SliverToBoxAdapter(child: SizedBox.shrink())
        ],
      ),
    );
  }
}
