import 'package:cinequest/app_drawer.dart';
// import 'package:cinequest/logout_screen.dart';
// import 'package:cinequest/setting_screen.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cinequest/trending_movie_slider.dart';
// import 'package:cinequest/top_rated_movie_slider.dart';
// import 'package:cinequest/upcoming_movie_slider.dart';
// import 'package:cinequest/saved_movies_screen.dart';

class SettingsScreen extends StatefulWidget {
   const SettingsScreen({super.key});

    @override
    State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('ACCOUNT', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 178, 54),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                        )
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('DISPLAY', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 178, 54),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                        )
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('NOTIFICATIONS', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 178, 54),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                        )
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('STORAGE', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 178, 54),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                        )
                      ),
                    )
                  ]
                ),            
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('ABOUT', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 178, 54),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                        )
                      ),
                    )
                  ]
                ),        
              ]
            )
          ),
        ],
      ),
      drawer: AppDrawer()
    );
  }
}