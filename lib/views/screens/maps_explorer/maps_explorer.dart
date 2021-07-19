import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/home_tab/components/components.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsExplorer extends StatefulWidget {
  final LatLng initialPosition;
  const MapsExplorer({Key? key, required this.initialPosition})
      : super(key: key);

  @override
  _MapsExplorerState createState() => _MapsExplorerState();
}

class _MapsExplorerState extends State<MapsExplorer> {
  static LatLng initialPosition = const LatLng(25.281235, 89.112174);
  CameraPosition _initialCameraPosition = CameraPosition(
      target: initialPosition, zoom: 11.0, tilt: 0.0, bearing: 0.0);
  final hathazariShop = const LatLng(22.3657, 91.7782);
  MapType _mapType = MapType.terrain;
  Set<Marker> shops = {};
  Set<Marker> markers() => {
        Marker(
            markerId: const MarkerId('Merker1'),
            position: hathazariShop,
            rotation: 20.0,
            // icon: pinLocationIcon,
            infoWindow: const InfoWindow(
                title: 'Yammy Food shop', snippet: 'Food shop')),
        Marker(
            markerId: const MarkerId('Yellow shop'),
            position: initialPosition,
            infoWindow: const InfoWindow(title: 'Food delivaty shop')),
        const Marker(
            markerId: MarkerId('Chunnu Foody'),
            position: LatLng(22.47017028372685, 91.78719147490759),
            infoWindow: InfoWindow(title: 'Food delivery'))
      };
  GoogleMapController? _mapController;
  late BitmapDescriptor pinLocationIcon;

  void changeMapeType() {
    setState(() {
      _mapType =
          _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  Stream<Position> cureentLocationStream() => Geolocator.getPositionStream();

  void onMapCreated(GoogleMapController contro) {
    _mapController = contro;
  }

  void animateCamera(LatLng cameraPosition) {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: cameraPosition, zoom: 11.0),
    ));
  }

  @override
  void initState() {
    super.initState();
    shops = {
      for (final single in RestaurentListItemModel.topRestaurentList)
        Marker(
            markerId: MarkerId(single.title),
            infoWindow: InfoWindow(title: single.title),
            position: single.position!)
    };
    _initialCameraPosition =
        CameraPosition(target: widget.initialPosition, zoom: 11.0);
    // animateCamera(widget.initialPosition);
  }

  getMarkerData() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1, size: Size(60, 60)),
        'assets/images/custom_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            mapType: _mapType,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            markers: shops,
            trafficEnabled: true,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10, left: 10),
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: RestaurentListItemModel.topRestaurentList.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              right: Dimentions.soLargeDimention),
                          child: GestureDetector(
                            onTap: () {
                              animateCamera(RestaurentListItemModel
                                  .topRestaurentList[index].position!);
                            },
                            child: Card(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.34,
                                width: MediaQuery.of(context).size.width * 0.84,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    RestaurentListItemModel
                                                        .topRestaurentList[
                                                            index]
                                                        .imageAdress),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimentions.smallDimention),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    RestaurentListItemModel
                                                        .topRestaurentList[
                                                            index]
                                                        .title,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorResources
                                                          .blueGrey,
                                                    ),
                                                    overflow: TextOverflow.fade,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    RestaurentListItemModel
                                                        .topRestaurentList[
                                                            index]
                                                        .subTitle,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: ColorResources
                                                            .grey
                                                            .withOpacity(0.7)),
                                                    softWrap: false,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Ratting(
                                                      ratting:
                                                          RestaurentListItemModel
                                                              .topRestaurentList[
                                                                  index]
                                                              .rating)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 50,
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            decoration: const BoxDecoration(
                                                color:
                                                    ColorResources.orangeAccent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.directions),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))),
          )
        ],
      ),
      appBar: AppBar(
        title: const Text(
          'Maps Explorer',
          style: TextStyle(
              color: ColorResources.red,
              fontFamily: Strings.notosansFontFamilly),
        ),
        backgroundColor: ColorResources.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.location_on,
                color: ColorResources.black,
              ))
        ],
      ),
    );
  }
}
