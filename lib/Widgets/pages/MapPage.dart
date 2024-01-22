import 'package:floating_pullup_card/floating_pullup_card.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/icon_text.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.searchKey}) : super(key: key);

  final String searchKey;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String GOONG_API = "v7v3WMJG0pFbtgEnbgyk8hvOeB59VPfciZ0XIGBd";
  String PUBLIC_ACCESS_TOKEN =
      "pk.eyJ1IjoidHJ1Y3Z5IiwiYSI6ImNscm5sd2pzazE2NjUyaW1oYmZyaHpyeXEifQ.CE4Gkbh5qm5Wc5amUrv0Sw";

  // input for search
  late String searchKey = widget.searchKey;
  num? lat = 10.775990235000052;
  num? lng = 106.66386249000004;
  num? latDes;
  num? lngDes;
  int? limit = 20;
  double? radius = 10;

  // output from search
  List<dynamic> places = [];
  List<dynamic> details = [];

  // open list of places
  bool openList = true;

  MapboxMap? mapboxMap;

  CircleAnnotationManager? _circleAnnotationManager;
  PolylinePoints polylinePoints = PolylinePoints();

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    await searchPlaces();
    for (var i = 0; i < places.length; i++) {
      await getDetail(places[i]['place_id']);
    }
    await getDistances();

    setState(() {
      // sort by distance
      details.sort(
          (a, b) => a['distance']['value'].compareTo(b['distance']['value']));
    });

    initMarker();
  }

  Future<void> searchPlaces() async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=$GOONG_API&input=$searchKey&location=$lat,$lng&limit=$limit&radius=$radius');

      var response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);
      places = jsonResponse['predictions'];
    } catch (e) {
      print('$e');
    }
  }

  Future<void> getDetail(String placesId) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/Detail?place_id=$placesId&api_key=$GOONG_API');

      var response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);
      details.add(jsonResponse['result']);
    } catch (e) {
      print('$e');
    }
  }

  Future<void> getDistances() async {
    String vehicle = "car";
    String origins =
        "https://rsapi.goong.io/DistanceMatrix?&vehicle=$vehicle&api_key=$GOONG_API&origins=";
    // origins
    origins += "$lat,$lng";
    //destinations
    origins += "&destinations=";
    for (var i = 0; i < details.length; i++) {
      if (i != 0) {
        origins += "|";
      }
      origins +=
          "${details[i]['geometry']['location']['lat']},${details[i]['geometry']['location']['lng']}";
    }

    try {
      final url = Uri.parse(origins);

      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body)['rows'][0]['elements'];
      for (int i = 0; i < details.length; i++) {
        details[i]['distance'] = jsonResponse[i]['distance'];
        details[i]['duration'] = jsonResponse[i]['duration'];
      }
    } catch (e) {
      print('$e');
    }
  }

  void initMarker() {
    mapboxMap?.annotations.createCircleAnnotationManager().then((value) async {
      _circleAnnotationManager = value;
      for (var detail in details) {
        final id = detail['place_id'];
        final lng = detail['geometry']['location']['lng'];
        final lat = detail['geometry']['location']['lat'];

        final options = CircleAnnotationOptions(
          geometry: Point(coordinates: Position(lng, lat)).toJson(),
          circleColor: Color.fromARGB(255, 255, 0, 0).value,
          circleRadius: 12.0,
        );

        await value.create(options);
      }

      await value.create(
        CircleAnnotationOptions(
          geometry: Point(coordinates: Position(lng!, lat!)).toJson(),
          circleColor: Color.fromARGB(255, 13, 255, 0).value,
          circleRadius: 12.0,
        ),
      );
    });
  }

  void removeLayer() async {
    await mapboxMap?.style.removeStyleLayer("line_layer");
    await mapboxMap?.style.removeStyleSource("line");
  }

  void findPath() async {
    if (lat != null && lng != null && lngDes != null && latDes != null) {
      final url = Uri.parse(
          'https://rsapi.goong.io/Direction?origin=$lat,$lng&destination=$latDes,$lngDes&vehicle=car&api_key=$GOONG_API');

      // mapboxMap?.setBounds(CameraBoundsOptions(
      //     bounds: CoordinateBounds(
      //         southwest: Point(
      //             // tay nam
      //             coordinates: Position(
      //           min(lng!, lngDes!),
      //           min(lat!, latDes!),
      //         )).toJson(),
      //         northeast: Point(
      //             coordinates: Position(
      //           max(lng!, lngDes!),
      //           max(lat!, latDes!),
      //         )).toJson(),
      //         infiniteBounds: true),
      //     maxZoom: 13,
      //     minZoom: 0,
      //     maxPitch: 10,
      //     minPitch: 0));

      // move the screen to the path
      mapboxMap?.setCamera(CameraOptions(
          center: Point(
                  coordinates:
                      Position((lng! + lngDes!) / 2, (lat! + latDes!) / 2))
              .toJson(),
          zoom: 7.0));
      mapboxMap?.flyTo(
          CameraOptions(
              anchor: ScreenCoordinate(x: 0, y: 0),
              zoom: 14,
              bearing: 0,
              pitch: 0),
          MapAnimationOptions(duration: 2000, startDelay: 0));

      var response = await http.get(url);
      final jsonResponse = jsonDecode(response.body);
      var route = jsonResponse['routes'][0]['overview_polyline']['points'];
      List<PointLatLng> result = polylinePoints.decodePolyline(route);
      List<List<double>> coordinates =
          result.map((point) => [point.longitude, point.latitude]).toList();

      String geojson = '''{
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "name": "Crema to Council Crest"
          },
          "geometry": {
            "type": "LineString",
            "coordinates": $coordinates
          }
        }
      ]
    }''';

      await mapboxMap?.style
          .addSource(GeoJsonSource(id: "line", data: geojson));
      var lineLayerJson = """{
     "type":"line",
     "id":"line_layer",
     "source":"line",
     "paint":{
     "line-join":"round",
     "line-cap":"round",
     "line-color":"rgb(51, 51, 255)",
     "line-width":9.0
     }
     }""";

      await mapboxMap?.style.addPersistentStyleLayer(lineLayerJson, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FloatingPullUpCardLayout(
      state: openList
          ? FloatingPullUpState.uncollapsed
          : FloatingPullUpState.collapsed,
      child: SizedBox(
        child: MapWidget(
          key: const ValueKey("mapWidget"),
          resourceOptions: ResourceOptions(accessToken: PUBLIC_ACCESS_TOKEN),
          cameraOptions: CameraOptions(
            center: Point(coordinates: Position(lng!, lat!)).toJson(),
            // zoom: 4.0,
          ),
          // styleUri: MapboxStyles.DARK,
          textureView: true,
          onMapCreated: _onMapCreated,
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        details[index]['name'],
                        style: ThemeConstants.storeTitleStyle,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconText(
                              icon: Icons.directions_car,
                              content: details[index]['distance']['text']),
                          SizedBox(
                            width: 10,
                          ),
                          IconText(
                              icon: Icons.timer,
                              content: details[index]['duration']['text']),
                        ],
                      )
                    ],
                  ),
                  subtitle: Text(details[index]['formatted_address']),
                  trailing: GestureDetector(
                    // see path to that restaurant
                    onTap: () async {
                      if (latDes !=
                              details[index]['geometry']['location']['lat'] ||
                          lngDes !=
                              details[index]['geometry']['location']['lng']) {
                        removeLayer();
                      }
                      setState(() {
                        latDes = details[index]['geometry']['location']['lat'];
                        lngDes = details[index]['geometry']['location']['lng'];
                        openList = false;
                      });

                      findPath();
                    },
                    child: Icon(
                      Icons.forest,
                      color: Color.fromARGB(255, 0, 128, 0),
                      size: 30,
                    ),
                  ),
                  onTap: () async {
                    // see location of that restaurant
                    if (latDes !=
                            details[index]['geometry']['location']['lat'] ||
                        lngDes !=
                            details[index]['geometry']['location']['lng']) {
                      removeLayer();
                    }
                    setState(() {
                      latDes = details[index]['geometry']['location']['lat'];
                      lngDes = details[index]['geometry']['location']['lng'];
                      openList = false;
                    });
                    mapboxMap?.setCamera(CameraOptions(
                        center: Point(
                                coordinates: Position(
                                    details[index]['geometry']['location']
                                        ['lng'],
                                    details[index]['geometry']['location']
                                        ['lat']))
                            .toJson(),
                        zoom: 12.0));
                    mapboxMap?.flyTo(
                        CameraOptions(
                            anchor: ScreenCoordinate(x: 0, y: 0),
                            zoom: 18,
                            bearing: 0,
                            pitch: 0),
                        MapAnimationOptions(duration: 2000, startDelay: 0));
                  },
                  onLongPress: () async {
                    // pick this restaurant
                    // add history

                    // open google map intent with start and end location
                  },
                ),
              );
            },
            itemCount: places.length,
            shrinkWrap: true,
          ),
        ],
      ),
    ));
  }
}
