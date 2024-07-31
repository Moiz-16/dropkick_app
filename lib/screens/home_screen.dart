import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropkick_app/data/constants.dart';
import 'package:dropkick_app/data/queries.dart';
import 'package:dropkick_app/widgets/header_with_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var shoes;

    return Query(
      options: QueryOptions(
        document: gql(getAllShoes),
        pollInterval: Duration(seconds: 60),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: kBackgroundColour,
                ),
                Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: kPrimaryColour,
                  highlightColor: Color(0xFFffe66e),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/test_logo_gold.png',
                        fit: BoxFit.cover,
                      ),
                      // child: Text(
                      //   "DropKick",
                      //   style: TextStyle(
                      //     fontSize: 70,
                      //     fontFamily: 'Pacifico',
                      //     // shadows: <Shadow>[
                      //     //   BoxShadow(
                      //     //     blurRadius: 20,
                      //     //     color: Colors.black,
                      //     //     offset: Offset.fromDirection(120, 6),
                      //     //   ),
                      //     // ],
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        shoes = result.data!["shoes"];
        print(shoes);

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "dropkick.io",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kPrimaryColour,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {/* Write listener code here */},
                  child: Icon(
                    Icons.settings, // add custom icons also
                  ),
                ),
              ),
            ],
            actionsIconTheme: IconThemeData(
              size: 25.0,
              color: kPrimaryColour,
            ),
            backgroundColor: kBackgroundColour,
            elevation: 6,
            shadowColor: kPrimaryColour.withOpacity(0.4),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            child: Column(
              children: [
                HeaderWithSearchbox(size: size),
                Expanded(
                  child: ListView.builder(
                    itemCount: shoes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.5, horizontal: 25),
                        child: GestureDetector(
                          onTap: () {
                            InfoScreen(context, shoes[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(5, 5),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                BoxShadow(
                                  offset: Offset(-9, -9),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 40,
                                  sigmaY: 40,
                                ),
                                child: Container(
                                  height: size.height * 0.20,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColour,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: size.height / 3,
                                          width: size.width / 3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  shoes[index]["image_url"]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 20)),
                                        Expanded(
                                          child: Container(
                                            //color: Colors.red,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        shoes[index]["brand"],
                                                        textScaleFactor: 1.1,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColour,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        shoes[index]["model"],
                                                        textScaleFactor: 1.6,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kTextColour,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      DateFormat.yMMMd().format(
                                                          DateTime.parse(shoes[
                                                                  index][
                                                              "release_date"])),
                                                      textScaleFactor: 1.1,
                                                      style: TextStyle(
                                                        color: kTextColour,
                                                      ),
                                                    ),
                                                    Text(
                                                      "£" +
                                                          shoes[index]["price"]
                                                              .toString(),
                                                      textScaleFactor: 1.1,
                                                      style: TextStyle(
                                                        color: kTextColour,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<dynamic> InfoScreen(
  BuildContext context,
  var shoe,
) {
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: size.height * 0.9,
      decoration: new BoxDecoration(
        color: kBackgroundColour,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: size.height * 0.08,
            width: size.width,
            child: Center(
              child: Text(
                shoe["model"],
                textScaleFactor: 1.5,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColour,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 0.85,
                    height: size.height * 0.4,
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    Container(
                      //margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage(shoe["image_url"]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 0.5,
                            color: kPrimaryColour.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 50,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      radius: 20,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Container(
                height: size.height * 0.20,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  color: kSecondaryColour,

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 0.5,
                      color: kPrimaryColour.withOpacity(0.1),
                    ),
                  ],

                  // border: Border.all(
                  //     //color: Colors.red[500],
                  //     ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Release Date:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour,
                            ),
                          ),
                          Text(
                            DateFormat.yMd()
                                .format(DateTime.parse(shoe["release_date"])),
                            style: TextStyle(
                              fontSize: 20,
                              color: kTextColour,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price:",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour,
                            ),
                          ),
                          Text(
                            "£${shoe["price"]}",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: kTextColour,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Style Code:",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour,
                            ),
                          ),
                          Text(
                            "£${shoe["price"]}",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: kTextColour,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Container(
                height: size.height * 0.12,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  color: kSecondaryColour,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 0.5,
                      color: kPrimaryColour.withOpacity(0.1),
                    ),
                  ],

                  // border: Border.all(
                  //     //color: Colors.red[500],
                  //     ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          height: size.height * 0.10,
                          //width: size.height * 0.10,
                          decoration: BoxDecoration(
                            color: kTextColour,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "£${shoe["price"]}",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour,
                            ),
                          ),
                          Text(
                            "TYPE",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: kTextColour,
                            ),
                          ),
                          Text(
                            "DATE",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextColour,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultSize / 2),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.check_circle),
                        color: Colors.green,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
