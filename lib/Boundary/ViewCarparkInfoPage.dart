import 'package:sg_carpark_availability/Controller/ReviewDatabse.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:sg_carpark_availability/Entity/Carpark.dart';
import 'package:sg_carpark_availability/Entity/Review.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'dart:math';

class CarparkInfoPage extends StatefulWidget {
  @override
  CarparkInfoPage(
      {Key? key,
      required this.carpark,
      required this.review,
      required this.currentLocation})
      : super(key: key);
  final Carpark carpark;
  final Review review;
  final LatLng currentLocation;
  @override
  _CarparkInfoPageState createState() => _CarparkInfoPageState();
}

class _CarparkInfoPageState extends State<CarparkInfoPage> {
  var reviewDB = ReviewDataBase();
  late double _distance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _distance = 110 *
        sqrt((widget.carpark.xCoord - widget.currentLocation.latitude) *
                (widget.carpark.xCoord - widget.currentLocation.latitude) +
            (widget.carpark.yCoord - widget.currentLocation.longitude) *
                (widget.carpark.yCoord - widget.currentLocation.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text('Carpark Infomation'),
              backgroundColor: Colors.amber.shade300,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.of(context).pop(),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                titleSection(
                  "Carpark Number",
                  widget.carpark.carParkNo,
                  Icon(
                    Icons.car_rental,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark address",
                  widget.carpark.address,
                  Icon(
                    Icons.home,
                    color: Colors.red[500],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Current Slot",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.carpark.currentSlot.toString(),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Total capacity",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.carpark.maxSlot.toString(),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Distance",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    "${_distance.toStringAsFixed(
                                            _distance.truncateToDouble() ==
                                                    _distance
                                                ? 0
                                                : 2)} km",
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                titleSection(
                  "Carpark Type",
                  widget.carpark.carParkType,
                  Icon(
                    Icons.merge_type,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Short Term Parking",
                  widget.carpark.shortTermParking,
                  Icon(
                    Icons.terrain,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Free Parking",
                  widget.carpark.freeParking,
                  Icon(
                    Icons.money_off,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Night Parking",
                  widget.carpark.nightParking,
                  Icon(
                    Icons.nightlight_round,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark Decks",
                  "${widget.carpark.carParkDecks} layers",
                  Icon(
                    Icons.stairs_rounded,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Gantry height",
                  "${widget.carpark.gantryHeight}m",
                  Icon(
                    Icons.height,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark basement",
                  widget.carpark.carParkBasement,
                  Icon(
                    Icons.stairs_sharp,
                    color: Colors.red[500],
                  ),
                ),
                titleSection("Review", "Cost",
                    buildStarReview(widget.review.cost, "Cost")),
                titleSection("Review", "Convenience",
                    buildStarReview(widget.review.convenience, "Convenience")),
                titleSection("Review", "Security",
                    buildStarReview(widget.review.security, "Security")),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.call, 'CALL', () {}),
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.near_me, 'ROUTE',
                          () async {
                        try {
                          final current = Coords(
                              widget.currentLocation.latitude,
                              widget.currentLocation.longitude);
                          final dest = Coords(
                              widget.carpark.xCoord, widget.carpark.yCoord);
                          final availableMaps = await MapLauncher.installedMaps;

                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Wrap(
                                      children: <Widget>[
                                        for (var map in availableMaps)
                                          ListTile(
                                            onTap: () => map.showDirections(
                                                origin: current,
                                                destination: dest,
                                                destinationTitle:
                                                    widget.carpark.address),
                                            title: Text(map.mapName),
                                            leading: Image(
                                              width: 32,
                                              height: 32,
                                              image: Svg(map.icon),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (e) {
                          print(e);
                        }
                      }),
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.share, 'SHARE', () {}),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget titleSection(String title, String displaytext, Widget icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  displaytext,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          icon,
        ],
      ),
    );
  }

  Widget buildStarReview(int mark, String reviewType) {
    return SmoothStarRating(
        allowHalfRating: false,
        onRatingChanged: (v) async {
          if (reviewType == "Cost") {
            int total = widget.review.cost * widget.review.numOfReviewCost;
            widget.review.numOfReviewCost++;
            widget.review.cost =
                (total + v.toInt()) ~/ widget.review.numOfReviewCost;
            reviewDB.updateReviewById(widget.review);
          }
          if (reviewType == "Convenience") {
            int total = widget.review.convenience *
                widget.review.numOfReviewConvenience;
            widget.review.numOfReviewConvenience++;
            widget.review.convenience =
                (total + v.toInt()) ~/ widget.review.numOfReviewConvenience;
            reviewDB.updateReviewById(widget.review);
          }
          if (reviewType == "Security") {
            int total =
                widget.review.security * widget.review.numOfReviewSecurity;
            widget.review.numOfReviewSecurity++;
            widget.review.security =
                (total + v.toInt()) ~/ widget.review.numOfReviewSecurity;
            reviewDB.updateReviewById(widget.review);
          }
        },
        starCount: 5,
        rating: mark.toDouble(),
        size: 40.0,
        color: Colors.amber.shade300,
        borderColor: Colors.amber.shade300,
        spacing: 0.0);
  }

  Column buildButtonColumn(
      Color color, IconData icon, String label, VoidCallback onPress) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(icon), color: color, onPressed: onPress),
        Container(
          margin: const EdgeInsets.only(top: 0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
