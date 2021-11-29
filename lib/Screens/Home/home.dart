import 'package:assesmentbyafridee/Screens/search/search.dart';
import 'package:assesmentbyafridee/controllers/authentication.dart';
import 'package:assesmentbyafridee/controllers/screens.dart';
import 'package:assesmentbyafridee/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authentication authenticationController = Get.put(Authentication());
  final Screens screenController = Get.put(Screens());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: GetBuilder<Screens>(
          builder: (sc){
           return BottomNavigationBar(
             onTap: (index){
               screenController.switchScreen(index);
             },
              currentIndex: sc.screenIndex,
              unselectedItemColor: textColorGrey,
              backgroundColor: primaryColor,
              selectedItemColor: otpPurpleborder,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout_rounded),
                  label: 'Log Out',
                ),
              ],
            );
          },
        ),
        appBar: AppBar(
          title: const Text(
            "Increments Inc.",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColorYellow, fontSize: 30),
          ),
          backgroundColor: primaryColor,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: GetBuilder<Screens>(
          builder: (sc){
           return sc.screenIndex==0? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: primaryColor,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: const [
                          HorizontalMovieCover(),
                          HorizontalMovieCover(),
                          HorizontalMovieCover(),
                          HorizontalMovieCover()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Trending Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: primaryColor,
                          child: ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              MovieTile(),
                              MovieTile(),
                              MovieTile(),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Featured Movies",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: primaryColor,
                          child: ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              MovieTile(),
                              MovieTile(),
                              MovieTile(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) : const Search();
          },
        ),
      ),
    );
  }
}

class HorizontalMovieCover extends StatelessWidget {
  const HorizontalMovieCover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/jumanji.jpg"),
            fit: BoxFit.cover
          ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              image: const DecorationImage(
                image: AssetImage("assets/images/movieCover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            height: 200,
            width: 160.0,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Movie name",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Action Adventure",
            style: TextStyle(
                color: textColorGrey,
                fontWeight: FontWeight.w700,
                fontSize: 10),
          )
        ],
      ),
    );
  }
}
